class Settings{
  bool _reset;
  bool _lowPower;
  String _name;

  Settings(this._reset, this._lowPower, this._name);

  Settings.empty() : _reset = false, _lowPower = false, _name = "";

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
        _name = json['name'];
}




