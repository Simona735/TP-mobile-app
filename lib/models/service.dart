class Service {
  String _counter = "";
  String _distanceFromSensor = "";
  bool _reset = false;

  Service(this._counter, this._distanceFromSensor, this._reset);


  bool get reset => _reset;

  set reset(bool value) {
    _reset = value;
  }

  String get distanceFromSensor => _distanceFromSensor;

  set distanceFromSensor(String value) {
    _distanceFromSensor = value;
  }

  String get counter => _counter;

  set counter(String value) {
    _counter = value;
  }

  Service.fromJson(Map<String, dynamic> json)
      : _counter = json['counter'],
        _distanceFromSensor = json['distance_from_senzor'],
        _reset = json['reset'];
}
