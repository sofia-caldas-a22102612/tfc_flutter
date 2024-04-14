import 'dart:collection';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart'; // Import the Test class with a prefix
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart'; // Import the Treatment class with a prefix



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
  String? _realId;
  int? _documentType;
  String? _lastProgramName;
  DateTime? _lastProgramDate;
  int? _userId;
  Test? _lastScreening; // Assuming Test is a valid class representing the last screening
  PatientStatus? _patientStatus;
  List<Treatment>? _treatmentList; // Use the prefix for the Treatment class
  HashSet<Test>? _testList; // Use the prefix for the Test class

  // Constructor 1: for Patient.withDetails
  Patient.withDetails(
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

  // Constructor 2: for the provided values
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
      Test? lastScreening,
      PatientStatus? patientStatus,
      ) : _lastScreening = lastScreening,
        _patientStatus = patientStatus;


  void updatePatientState(PatientStatus status) {
    this._patientStatus = status;
  }

  void addRastreio(Test rastreio) {
    this._lastScreening = rastreio;
  }

  void addTest(Test newTest) {
    if (_testList == null) {
      _testList = HashSet<Test>() as HashSet<
          Test>?; // Initialize the _testList if it's null
    }

    // Check if newTest already exists in the _testList
    bool alreadyExists = _testList!.contains(newTest);

    if (alreadyExists) {
      // If newTest already exists, update it
      _testList!.add(newTest as Test); // Add the new test
    } else {
      // If newTest doesn't exist, add it to the _testList
      _testList!.add(newTest as Test);
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
  GenderType getGender() {
    return _gender;
  }

  int getAge() {
    return _age;
  }

  // Getter method for realId
  String? getRealId() {
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
    return _patientStatus;
  }

  String getPatientPositiveScreening() {
    if (_lastScreening == true) {
      return 'Rastreio Positivo';
    }
    if (_lastScreening == null) {
      return 'Sem Rastreios';
    }
    else {
      return "Ultimo Rastreio Negativo";
    }
  }



  Patient.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as String,
        _name = json['name'] as String,
        _cc = json['cc'] as String,
        _birthDate = DateTime.parse(json['birthDate'] as String),
        _gender = GenderType.values[json['gender'] as int],
        _age = json['age'] as int,
        _realId = json['realId'] as String?, // Ensure this matches your data type
        _documentType = json['documentType'] as int?,
        _lastProgramName = json['lastProgramName'] as String?,
        _lastProgramDate = json['lastProgramDate'] != null
            ? DateTime.parse(json['lastProgramDate'] as String)
            : null,
        _userId = json['userId'] as int,
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
      'id': _id,
      'name': _name,
      'cc': _cc,
      'birthDate': _birthDate.toIso8601String(),
      'gender': _gender.index,
      'age': _age,
      'realId': _realId,
      'documentType': _documentType,
      'lastProgramName': _lastProgramName,
      'lastProgramDate': _lastProgramDate?.toIso8601String(),
      'userId': _userId,
      'patientStatus': _patientStatus!.index,
      'treatmentList': _treatmentList?.map((treatment) => treatment.toJson()).toList(),
      'testList': _testList?.map((test) => test.toJson()).toList(),
    };
  }

}
