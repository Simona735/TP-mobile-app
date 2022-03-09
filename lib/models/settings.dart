class Settings{
  bool _reset;
  bool _lowPower;
  String _name;
  bool _notif_new;
  bool _notif_full;
  bool _notif_empty;

  Settings(this._reset, this._lowPower, this._name, this._notif_empty,
      this._notif_full, this._notif_new);

  Settings.empty()
      : _reset = false,
        _lowPower = false,
        _name = "",
        _notif_full = true,
        _notif_new = true,
        _notif_empty = true;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get lowPower => _lowPower;

  set lowPower(bool value) {
    _lowPower = value;
  }

  bool get reset => _reset;

  set reset(bool value) {
    _reset = value;
  }

  Settings.fromJson(Map<String, dynamic> json)
      : _reset = json['reset'],
        _lowPower = json['low_power'],
        _name = json['name'],
        _notif_empty = json['notif_empty'],
        _notif_new = json['notif_new'],
        _notif_full = json['notif_full'];

}




