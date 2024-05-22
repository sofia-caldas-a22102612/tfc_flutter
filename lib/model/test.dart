import 'package:tfc_flutter/model/patient.dart';


class Test {
  int? id;
  bool? diagnosis;
  int? type;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;
  Patient? patient;

  Test({
    this.id,
    this.diagnosis = true,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    this.patient,
  });


  Test.rastreio({
    this.id,
    this.diagnosis = false,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    this.patient,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      diagnosis: json['diagnosis'],
      type: json['type'],
      testDate: json['testDate'] != null ? DateTime.parse(json['testDate']) : null,
      resultDate: json['resultDate'] != null ? DateTime.parse(json['resultDate']) : null,
      result: json['result'],
      testLocation: json['testLocation'],
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diagnosis'] = diagnosis;
    data['type'] = type;
    data['testDate'] = testDate?.toIso8601String();
    data['resultDate'] = resultDate?.toIso8601String();
    data['result'] = result;
    data['testLocation'] = testLocation;
    data['patient'] = patient?.toJson();
    return data;
  }



}
