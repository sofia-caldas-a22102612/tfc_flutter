import 'package:tfc_flutter/model/patient.dart';

class Test {
  int? _id;
  int? _type;
  DateTime? _testDate;
  DateTime? _resultDate;
  bool? _result;
  int? _testLocation;
  int _patientId;

  Test({
    int? id,
    int? type,
    DateTime? testDate,
    DateTime? resultDate,
    bool? result,
    int? testLocation,
    required int patientId,
  })  : _id = id,
        _type = type,
        _testDate = testDate,
        _resultDate = resultDate,
        _result = result,
        _testLocation = testLocation,
        _patientId = patientId;

  DateTime? getTestDate() => _testDate;

  bool? getResult() => _result;

  String getLocationString() {
    switch (_testLocation) {
      case 1:
        return 'Instalações Adp';
      case 2:
        return 'Hospital';
      case 3:
        return 'Unidade Móvel';
      default:
        return 'Por Definir';
    }
  }

  String getTypeString() {
    switch (_type) {
      case 1:
        return 'Rastreio';
      case 0:
        return 'Diagnóstico';
      default:
        return 'Por Definir';
    }
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      type: json['type'],
      testDate: json['testDate'] != null ? DateTime.parse(json['testDate']) : null,
      resultDate: json['resultDate'] != null ? DateTime.parse(json['resultDate']) : null,
      result: json['result'],
      testLocation: json['testLocation'],
      patientId: json['patientId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': _type,
      'testLocation': _testLocation,
      'patientId': _patientId,
    };
    if (_result != null) {
      data['result'] = _result!.toString();
    }
    if (_testDate != null) {
      data['testDate'] = _testDate!.toIso8601String();
    }
    if (_resultDate != null) {
      data['resultDate'] = _resultDate!.toIso8601String();
    }
    return data;
  }
}
