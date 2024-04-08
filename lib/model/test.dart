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
  //User? user;


  Test({
    this.id,
    this.diagnosis,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    //this.patient,
    //this.user,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      diagnosis: json['diagnosis'],
      type: json['type'],
      testDate: DateTime.parse(json['test_date']),
      resultDate: json['result_date'] != null ? DateTime.parse(json['result_date']) : null,
      result: json['result'],
      testLocation: json['test_location'],
      // Assuming Patient and User classes are already defined and have appropriate constructors
      //patient: Patient.fromJson(json['patient']),
      //user: User.fromJson(json['user']),
    );
  }
}
