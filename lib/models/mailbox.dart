import 'package:tp_mobile_app/models/service.dart';
import 'package:tp_mobile_app/models/settings.dart';

class Mailbox {
  Service _service;
  Settings _settings;

  Mailbox(this._service, this._settings);


  Settings get settings => _settings;

  set settings(Settings value) {
    _settings = value;
  }

  Service get service => _service;

  set service(Service value) {
    _service = value;
  }
}
