class Settings{
  bool _reset;
  bool _lowPower;
  String _name;
  bool _notif_new;
  bool _notif_full;
  bool _notif_empty;
  int _UCI;
  int _UEC;
  int _UECI;
  double _UT;

  Settings(this._reset, this._lowPower, this._name, this._notif_empty,
      this._notif_full, this._notif_new, this._UCI, this._UEC,
      this._UECI, this._UT);

  Settings.empty()
      : _reset = false,
        _lowPower = false,
        _name = "",
        _notif_full = true,
        _notif_new = true,
        _notif_empty = true,
        _UCI = 0,
        _UEC = 0,
        _UECI = 0,
        _UT = 0.0;

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


  bool get notif_new => _notif_new;

  set notif_new(bool value) {
    _notif_new = value;
  }

  bool get notif_full => _notif_full;

  set notif_full(bool value) {
    _notif_full = value;
  }

  bool get notif_empty => _notif_empty;

  set notif_empty(bool value) {
    _notif_empty = value;
  }

  int get UCI => _UCI;

  set UCI(int value) {
    _UCI = value;
  }

  int get UEC => _UEC;

  set UEC(int value) {
    _UEC = value;
  }

  int get UECI => _UECI;

  set UECI(int value) {
    _UECI = value;
  }


  double get UT => _UT;

  set UT(double value) {
    _UT = value;
  }

  Settings.fromJson(Map<String, dynamic> json)
      : _reset = json['reset'],
        _lowPower = json['low_power'],
        _name = json['name'],
        _notif_empty = json['notif_empty'],
        _notif_new = json['notif_new'],
        _notif_full = json['notif_full'],
        _UCI = json['UCI'],
        _UEC = json['UEC'],
        _UECI = json['UECI'],
        _UT = json['UT'];


}




