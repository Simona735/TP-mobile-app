class Settings{
  String _dutyCycle;
  int _limit;
  bool _lowPower;
  String _name;

  Settings(this._dutyCycle, this._limit, this._lowPower, this._name);

  Settings.empty() : _dutyCycle = "", _limit = 1, _lowPower = false, _name = "";

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get lowPower => _lowPower;

  set lowPower(bool value) {
    _lowPower = value;
  }

  int get limit => _limit;

  set limit(int value) {
    _limit = value;
  }

  String get dutyCycle => _dutyCycle;

  set dutyCycle(String value) {
    _dutyCycle = value;
  }

  Settings.fromJson(Map<String, dynamic> json)
      : _dutyCycle = json['duty_cycle'],
        _limit = json['limit'],
        _lowPower = json['low_power'],
        _name = json['name'];
}




