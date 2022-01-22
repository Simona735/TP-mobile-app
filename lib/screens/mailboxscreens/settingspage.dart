import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'package:tp_mobile_app/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    // final controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nastavenia"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.fingerprint, size: 35),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text("Biometrické prihlásenie",
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                Obx(
                  () => Switch(
                    value: controller.isSwitched.value,
                    onChanged: (value) => {
                      controller.isSwitched.value = value,
                      controller.saveSwitchState("switchState", value),
                      if (controller.isSwitched.value == true)
                        {
                          controller.pin.clear(),
                          controller.confirmPin.clear(),
                          showMaterialModalBottomSheet(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () async {
                                controller.deletePin();
                                // controller.isSwitched.value = false;
                                // controller.saveSwitchState(
                                //     "switchState", false);
                                return true;
                              },
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                // controller: ModalScrollController.of(context),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Form(
                                        key: controller.formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              obscureText: true,
                                              maxLength: controller.pinSize,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: controller.pin,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Pole je prázdne';
                                                }
                                                if (value.length <
                                                    controller.pinSize) {
                                                  return 'PIN je príliš krátky';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  labelText: 'Zadaj PIN'),
                                            ),
                                            TextFormField(
                                              obscureText: true,
                                              maxLength: controller.pinSize,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: controller.confirmPin,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Pole je prázdne';
                                                }
                                                if (value.length <
                                                    controller.pinSize) {
                                                  return 'PIN je príliš krátky';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              decoration: const InputDecoration(
                                                  labelText: 'Potvrď PIN'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            controller.checkPin()
                                                ? Navigator.of(context).pop()
                                                : controller
                                                    .showErrorDialog(context);
                                          }
                                        },
                                        child: const Text("Uložiť"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        },
                      if (controller.isSwitched.value == false)
                        {
                          controller.deletePin(),
                        }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                        Icons.dark_mode_outlined, size: 35
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("Tmavá téma", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                Obx(
                  () => Switch(
                    value: controller.isDarkTheme.value,
                    onChanged: (value) {
                      controller.isDarkTheme.value = value;
                      controller.saveSwitchState("darkTheme", value);
                      if (value) {
                        Get.changeThemeMode(ThemeMode.dark);
                        // SettingsPage.is_dark = false;
                      } else {
                        Get.changeThemeMode(ThemeMode.light);
                        // SettingsPage.is_dark = true;
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
