import 'package:get/get.dart';
import 'package:tp_mobile_app/firebase/database.dart';
import 'package:tp_mobile_app/models/mailbox.dart';

class ListOfMailboxesController extends GetxController{
  final mailboxes = Future.value(<String, Mailbox>{}).obs;
  final data = <String, Mailbox>{}.obs;

  @override
  void onInit() async {
    mailboxes.value = Database.getMailboxes();
    super.onInit();
  }

  void setData(data){
    this.data.value = data;
  }
}
