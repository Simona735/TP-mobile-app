class Service {
  int _counter;
  int _distanceFromSensor;
  bool _reset;

  Service(this._counter, this._distanceFromSensor, this._reset);

  Service.empty() : _counter = 0, _distanceFromSensor = 0, _reset = false;

  bool get reset => _reset;

  set reset(bool value) {
    _reset = value;
  }

  int get distanceFromSensor => _distanceFromSensor;

  set distanceFromSensor(int value) {
    _distanceFromSensor = value;
  }

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
  }

  Service.fromJson(Map<String, dynamic> json)
      : _counter = json['counter'],
        _distanceFromSensor = json['distance_from_senzor'],
        _reset = json['reset'];
}
