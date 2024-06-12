import 'dart:collection';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart'; // Import the Test class
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart'; // Import the Treatment class

class PatientState {
  String status;
  DateTime? statusDate;

  PatientState(this.status, this.statusDate);

  PatientState.fromJson(Map<String, dynamic> json)
      : status = (json['status'] as String).toUpperCase(),
        statusDate = json['statusDate'] != null ? DateTime.parse(json['statusDate'] as String) : null;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusDate': statusDate?.toIso8601String(),
    };
  }
}

enum PatientStatus {
  NED, // no evidence of disease
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
  Test?
      _lastScreening; // Assuming Test is a valid class representing the last screening
  PatientStatus? _patientStatus;
  DateTime? _patientStatusDate;


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
  )   : _lastScreening = lastScreening,
        _patientStatus = patientStatus;

  // Constructor for Zeus
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


  bool? hasPositiveRastreio() {
    return _lastScreening?.getResult();
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

  String getPatientStateString() {
    return getPatientState()!
        .toString()
        .split('.')
        .last; // Return the enum value without the enum type prefix
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

  PatientStatus? getPatientState() {
    if (_patientStatus == null) {
      _patientStatus = PatientStatus.NED;
    }
    return _patientStatus;
  }

  String getPatientPositiveScreening() {
    if (_lastScreening == null) {
      return 'Sem Rastreios';
    }
    if (_lastScreening!.getResult() == true) {
      return 'Rastreio Positivo';
    } else {
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
      : _idZeus = json['utente_id'] as int,
        _name = json['utente_nome'] as String,
        _birthDate = DateTime.parse(json['utente_data_nascimento'] as String),
        _gender = json['utente_genero'] == 'Masculino'
            ? GenderType.male
            : GenderType.female;

  Patient.fromJson(Map<String, dynamic> json)
      : _idZeus = json['idZeus'] as int,
        _name = json['name'] as String,
        _cc = json['cc'] as String?,
        _birthDate = DateTime.parse(json['birthDate'] as String),
        _gender = json['gender'] is int
            ? GenderType.values[json['gender'] as int]
            : GenderType.values[int.parse(json['gender'] as String)],
        _realId = json['realId'] as String?,
        _documentType = json['documentType'] as String?,
        _lastProgramName = json['lastProgramName'] as String?,
        _lastProgramDate = json['lastProgramDate'] != null
            ? DateTime.parse(json['lastProgramDate'] as String)
            : null,
        _userId = json['userId'] as int?,
        _lastScreening = json['lastScreening'] != null ? Test.fromJson(json['lastScreening']) : null,
        _patientStatus = json['state'] != null ? PatientStatus.values.firstWhere((e) => e.toString().split('.').last == json['state']) : null,
        _patientStatusDate = json['statusDate'] != null ? DateTime.parse(json['statusDate'] as String) : null;

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
      'state': _patientStatus?.toString().split('.').last,
      'statusDate': _patientStatusDate?.toIso8601String(),
    };
  }
}
