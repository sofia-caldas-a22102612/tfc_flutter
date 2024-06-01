import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart'; // Import the Test class with a prefix
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart'; // Import the Treatment class with a prefix



enum PatientStatus {
  NED,  // no evidence of disease
  POSITIVE_SCREENING,
  POSITIVE_DIAGNOSIS,
  TREATMENT,
  POST_TREATMENT_ANALYSIS,
  FINISHED, //todo remove
  NOT_IN_DATABASE
}

class Patient {
  int _idZeus;
  String _name;
  String? _cc;
  DateTime _birthDate;
  GenderType _gender;
  String? _realId;
  String? _documentType;
  String? _lastProgramName;
  DateTime? _lastProgramDate;
  int? _userId;
  Test? _lastScreening; // Assuming Test is a valid class representing the last screening
  PatientStatus? _patientStatus;
  DateTime? _patientStatusDate;
  List<Treatment>? _treatmentList; // Use the prefix for the Treatment class
  Treatment? _currentTreatment;
  HashSet<Test>? _testList; // Use the prefix for the Test class


  // Constructor 1: for Patient.withDetails
  Patient.withDetails(
      this._idZeus,
      this._name,
      this._cc,
      this._birthDate,
      this._gender,
      this._realId,
      this._documentType,
      this._lastProgramName,
      this._lastProgramDate,
      this._userId,
      this._lastScreening,
      this._patientStatus,
      );

  // Constructor 2: for the provided values
  Patient(
      this._idZeus,
      this._name,
      this._cc,
      this._birthDate,
      this._gender,
      this._realId,
      this._documentType,
      this._lastProgramName,
      this._lastProgramDate,
      this._userId,
      Test? lastScreening,
      PatientStatus? patientStatus,
      ) : _lastScreening = lastScreening,
        _patientStatus = patientStatus;


  //todo adicionei este builder devido ao estado nao existir no zeus
  Patient.fromZeus(
      this._idZeus,
      this._name,
      this._cc,
      this._birthDate,
      this._gender,
      this._realId,
      this._documentType,
      this._lastProgramName,
      this._lastProgramDate,
      );

  void updatePatientState(PatientStatus status, DateTime? statusDate) {
    _patientStatus = status;
    _patientStatusDate = statusDate;
  }

  void addRastreio(Test rastreio) {
    _lastScreening = rastreio;
  }


  void addTest(Test newTest) {
    _testList ??= HashSet<Test>() as HashSet<
          Test>?;

    // Check if newTest already exists in the _testList
    bool alreadyExists = _testList!.contains(newTest);

    if (alreadyExists) {
      // If newTest already exists, update it
      _testList!.add(newTest); // Add the new test
    } else {
      // If newTest doesn't exist, add it to the _testList
      _testList!.add(newTest);
    }
  }

  void addTreatment(Treatment newTreatment) {
    this._currentTreatment = newTreatment;
  }


  bool? hasPositiveRastreio(){
    return _lastScreening!.result;
  }

  // Getter method for name
  String getName() {
    return _name;
  }

  // Getter method for cc
  String? getCC() {
    return _cc;
  }

  // Getter method for id
  int getIdZeus() {
    return _idZeus;
  }

  String getPatientStateString(){
    return getPatientState()!.toString().split('.').last; // Return the enum value without the enum type prefix
  }

  DateTime? get patientStatusDate => _patientStatusDate;

  // Getter method for age
  DateTime getBirthdate() {
    return _birthDate;
  }

  //get gender
  GenderType getGender() {
    return _gender;
  }

  // Getter method for realId
  String? getRealId() {
    return _realId;
  }

  // Getter method for documentType
  String? getDocumentType() {
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
  int? getUserId() {
    return _userId;
  }

  // Getter method for lastScreening
  Test? getLastScreening() {
    return _lastScreening;
  }

  List<Treatment>? getTreatmentList() {
    return _treatmentList;
  }


  Treatment getCurrentTreatment() {
    return _treatmentList!.last;
  }

  PatientStatus? getPatientState() {
    if(_patientStatus==null){
      _patientStatus = PatientStatus.NED;
    }
    return _patientStatus;
  }

  String getPatientPositiveScreening() {
    if (_lastScreening == null) {
      return 'Sem Rastreios';
    }
    if (_lastScreening!.result == true) {
      return 'Rastreio Positivo';
    }

    else {
      return "Ultimo Rastreio Negativo";
    }
  }

  Map<String, dynamic> toJsonZeus() {
    return {
      'idZeus': _idZeus,
      'name': _name,
      'birthDate': _birthDate.toIso8601String(),
      'gender': _gender == GenderType.male ? 'Masculino' : 'Feminino',
    };
  }


  Patient.fromJsonZeus(Map<String, dynamic> json)
      : _idZeus = json['idZeus'] as int,
        _name = json['name'],
        _birthDate = DateTime.parse(json['birthDate'] as String),
        _gender = json['gender'] == 'Masculino' ? GenderType.male : GenderType.female;


  Patient.fromJson(Map<String, dynamic> json)
      : _idZeus = json['idZeus'] as int,
        _name = json['name'] as String,
        _cc = json['cc'] as String,
        _birthDate = DateTime.parse(json['birthDate'] as String),
        _gender = GenderType.values[json['gender'] as int],
        _realId = json['realId'] as String?, // Ensure this matches your data type
        _documentType = json['documentType'] as String?,
        _lastProgramName = json['lastProgramName'] as String?,
        _lastProgramDate = json['lastProgramDate'] != null
            ? DateTime.parse(json['lastProgramDate'] as String)
            : null,
        _userId = json['userId'] as int,
        _currentTreatment = json['currentTreatment'] as Treatment,
        _patientStatus =
        PatientStatus.values[json['patientStatus'] as int],
        _treatmentList = (json['treatmentList'] as List<dynamic>?)
            ?.map((treatmentJson) => Treatment.fromJson(treatmentJson))
            .toList(),
        _testList = HashSet<Test>.from(
            (json['testList'] as List<dynamic>?)
                ?.map((testJson) => Test.fromJson(testJson as Map<String, dynamic>)) ?? []);

  Map<String, dynamic> toJson() {
    return {
      'idZeus': _idZeus,
      'name': _name,
      'cc': _cc,
      'birthDate': _birthDate.toIso8601String(),
      'gender': _gender.index,
      'realId': _realId,
      'documentType': _documentType,
      'lastProgramName': _lastProgramName,
      'lastProgramDate': _lastProgramDate?.toIso8601String(),
      'userId': _userId,
      'lastScreening': _lastScreening?.toJson(),
      'patientStatus': _patientStatus?.index, // Include patient status here
      'treatmentList': _treatmentList?.map((treatment) => treatment.toJson()).toList(),
      'testList': _testList?.map((test) => test.toJson()).toList(),
      'currentTreatment': _currentTreatment?.toJson(),
    };
  }



  Enum stringToPatientStatus(str) {
    switch (str) {
      case "NED":
        return PatientStatus.NED;
      case "POSITIVE_SCREENING_DIAGNOSIS":
        return PatientStatus.POSITIVE_SCREENING;
      case "POSITIVE_DIAGNOSIS":
        return PatientStatus.POSITIVE_DIAGNOSIS;
      case "TREATMENT":
        return PatientStatus.TREATMENT;
      case "POST_TREATMENT_ANALYSIS":
        return PatientStatus.POST_TREATMENT_ANALYSIS;
      case "FINISHED":
        return PatientStatus.FINISHED;
      default:
        return PatientStatus.NOT_IN_DATABASE;
    }
  }

}
