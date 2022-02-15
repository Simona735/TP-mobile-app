import 'package:tp_mobile_app/models/settings.dart';

class Mailbox {
  Settings _settings;

  Mailbox(this._settings);


  Settings get settings => _settings;

  set settings(Settings value) {
    _settings = value;
  }
}
