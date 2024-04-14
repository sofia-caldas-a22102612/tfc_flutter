import 'dart:collection';

import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart' as TestModel; // Import the Test class with a prefix
import 'package:tfc_flutter/model/treatment.dart' as TreatmentModel; // Import the Treatment class with a prefix
import 'package:tfc_flutter/model/treatment.dart';

enum PatientStatus {
  NED,
  POSITIVE_SCREENING_DIAGNOSIS,
  POSITIVE_DIAGNOSIS,
  TREATMENT,
  POST_TREATMENT_ANALYSIS,
  FINISHED
}

class Patient {
  String _id;
  String _name;
  String _cc;
  DateTime _birthDate;
  GenderType _gender;
  int _age;
  int? _realId;
  int? _documentType;
  String? _lastProgramName;
  DateTime? _lastProgramDate;
  int _userId;
  Test? _lastScreening; // Assuming Test is a valid class representing the last screening
  PatientStatus _patientStatus;
  List<TreatmentModel.Treatment>? _treatmentList; // Use the prefix for the Treatment class
  HashSet<TestModel.Test>? _testList; // Use the prefix for the Test class

  Patient(
      this._id,
      this._name,
      this._cc,
      this._birthDate,
      this._gender,
      this._age,
      this._realId,
      this._documentType,
      this._lastProgramName,
      this._lastProgramDate,
      this._userId,
      this._lastScreening,
      this._patientStatus,
      );

  void updatePatientState(PatientStatus status){
    this._patientStatus = status;
  }

  void addRastreio(Test rastreio){
    this._lastScreening = rastreio;
  }

  void addTest(Test newTest) {
    if (_testList == null) {
      _testList = HashSet<Test>() as HashSet<TestModel.Test>?; // Initialize the _testList if it's null
    }

    // Check if newTest already exists in the _testList
    bool alreadyExists = _testList!.contains(newTest);

    if (alreadyExists) {
      // If newTest already exists, update it
      _testList!.add(newTest as TestModel.Test);    // Add the new test
    } else {
      // If newTest doesn't exist, add it to the _testList
      _testList!.add(newTest as TestModel.Test);
    }
  }

  // Getter method for name
  String getName() {
    return _name;
  }

  // Getter method for cc
  String getCC() {
    return _cc;
  }

  // Getter method for id
  String getId() {
    return _id;
  }

  // Getter method for age
  DateTime getBirthdate() {
    return _birthDate;
  }

  //get gender
  GenderType getGender(){
    return _gender;
  }

  int getAge(){
    return _age;
  }

  // Getter method for realId
  int? getRealId() {
    return _realId;
  }

  // Getter method for documentType
  int? getDocumentType() {
    return _documentType;
  }

  // Getter method for lastProgramName
  String? getLastProgramName() {
    return _lastProgramName;
  }

  // Getter method for lastProgramDate
  DateTime? getLastProgramDate() {
    return _lastProgramDate;
  }

  // Getter method for userId
  int getUserId() {
    return _userId;
  }

  // Getter method for lastScreening
  Test? getLastScreening() {
    return _lastScreening;
  }

  List<Treatment>? getTreatmentList(){
    return _treatmentList;
  }


  Treatment getCurrentTreatment(){
    return _treatmentList!.last;
  }

  PatientStatus getPatientState(){
    return _patientStatus;
  }

  String getPatientPositiveScreening(){
    if(_lastScreening==true){
      return 'Rastreio Positivo';
    }
    if(_lastScreening==null){
      return 'Sem Rastreios';
    }
    else{
      return "Ultimo Rastreio Negativo";
    }

  }


  factory Patient.fromJSON(Map<String, dynamic> json) {
    return Patient(
      json['utente_id'],
      json['utente_nome'],
      json['utente_cc'],
      DateTime.parse(json['utente_data_nascimento']),
      json['utente_genero'] == '1' ? GenderType.male : GenderType.female,
      json['utente_age'],
      json['utente_real_id'],
      json['utente_document_type'],
      json['last_program_name'],
      DateTime.parse(json['last_program_date']),
      json['id_user'],
      TestModel.Test.fromJson(json['last_screening']) as TreatmentModel.Test?,
      json['state'],
    );
  }






}
