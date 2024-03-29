class Settings{
  bool _lowPower;
  String _name;
  bool _notif_new;
  bool _notif_full;
  bool _notif_empty;
  int _UCI;
  int _UEC;
  int _UECI;
  double _UT;
  String _last_event;
  int _last_event_timestamp;

  Settings(this._lowPower, this._name, this._notif_empty,
      this._notif_full, this._notif_new, this._UCI, this._UEC,
      this._UECI, this._UT, this._last_event, this._last_event_timestamp);

  Settings.empty()
      : _lowPower = false,
        _name = "",
        _notif_full = true,
        _notif_new = true,
        _notif_empty = true,
        _UCI = 300,
        _UEC = 4,
        _UECI = 500,
        _UT = 0.1,
        _last_event = "Prázdna schránka",
        _last_event_timestamp = DateTime.now().millisecondsSinceEpoch;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get lowPower => _lowPower;

  set lowPower(bool value) {
    _lowPower = value;
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

  String get last_event => _last_event;

  set last_event(String value) {
    _last_event = value;
  }

  int get last_event_timestamp => _last_event_timestamp;

  set last_event_timestamp(int value) {
    _last_event_timestamp = value;
  }

  String get last_event_timestamp_formated {
    String date = '';
    DateTime dateTmp = DateTime.fromMillisecondsSinceEpoch(last_event_timestamp);
    date = date + dateTmp.day.toString() + '.';
    date = date + dateTmp.month.toString() + '.';
    date = date + dateTmp.year.toString() + ' ';
    date = date + dateTmp.hour.toString() + ':';
    date = date + dateTmp.minute.toString();
    return date;
  }

  Settings.fromJson(Map<String, dynamic> json)
      : _lowPower = json['low_power'],
        _name = json['name'],
        _notif_empty = json['notif_empty'],
        _notif_new = json['notif_new'],
        _notif_full = json['notif_full'],
        _UCI = json['UCI'],
        _UEC = json['UEC'],
        _UECI = json['UECI'],
        _UT = json['UT'] * 1.0,
        _last_event = json['last_event'],
        _last_event_timestamp = json['last_event_timestamp'];


}




