import 'package:tfc_flutter/model/patient.dart';

class Rastreio {
  int? id;
  bool? diagnosis;
  int? type;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;
  Patient? patient;
  // User? user;

  Rastreio({
    this.id,
    this.diagnosis,
    this.type,
    this.testDate,
    this.resultDate,
    this.result,
    this.testLocation,
    this.patient,
    // this.user,
  });

  factory Rastreio.fromJson(Map<String, dynamic> json) {
    return Rastreio(
      id: json['id'],
      diagnosis: json['diagnosis'],
      type: json['type'],
      testDate: DateTime.parse(json['test_date']),
      resultDate: json['result_date'] != null ? DateTime.parse(json['result_date']) : null,
      result: json['result'],
      testLocation: json['test_location'],
      // Assuming Patient and User classes are already defined and have appropriate constructors
      // patient: Patient.fromJson(json['patient']),
      // user: User.fromJson(json['user']),
    );
  }
}

class RastreioBuilder {
  int? id;
  bool? diagnosis;
  int? type;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;
  Patient? patient;
  // User? user;

  RastreioBuilder();

  RastreioBuilder fromParameters(int id, String testDate, String resultDate, bool result, int testLocation) {
    this.id = id;
    this.testDate = DateTime.parse(testDate);
    this.resultDate = DateTime.parse(resultDate);
    this.result = result;
    this.testLocation = testLocation;
    return this;
  }

  RastreioBuilder withDiagnosis(bool diagnosis) {
    this.diagnosis = diagnosis;
    return this;
  }

  RastreioBuilder withType(int type) {
    this.type = type;
    return this;
  }

  RastreioBuilder withPatient(Patient patient) {
    this.patient = patient;
    return this;
  }

  Rastreio build() {
    return Rastreio(
      id: id,
      diagnosis: diagnosis,
      type: type,
      testDate: testDate,
      resultDate: resultDate,
      result: result,
      testLocation: testLocation,
      patient: patient,
      // user: user,
    );
  }

  bool? getResult(){
    return result;
  }
}

