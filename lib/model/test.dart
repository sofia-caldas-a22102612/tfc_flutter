import 'package:tfc_flutter/model/patient.dart';

class Test {
  int? id;
  int? type;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;
  Patient patient;

  Test({
    this.id,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    required this.patient,
  });

  Test.rastreio({
    this.id,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    required this.patient,
  });


  String getLocationString() {
    switch (testLocation) {
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
    switch (type) {
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
      patient: Patient.fromJson(json['patient']), // No need for null check as patient is required
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['testDate'] = testDate?.toIso8601String();
    data['resultDate'] = resultDate?.toIso8601String();
    data['result'] = result;
    data['testLocation'] = testLocation;
    data['patient'] = patient.toJson();
    return data;
  }

}
