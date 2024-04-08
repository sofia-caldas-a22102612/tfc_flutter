import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/treatment.dart';
import 'package:tfc_flutter/model/rastreio.dart';

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
  Rastreio? _lastScreening; // Assuming Test is a valid class representing the last screening
  //PatientStatus _state;
  List<Treatment>? _treatmentList;

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
      //this._state,
      );

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
  Rastreio? getLastScreening() {
    return _lastScreening;
  }

  List<Treatment>? getTreatmentList(){
    return _treatmentList;
  }


  Treatment getCurrentTreatment(){
    return _treatmentList!.last;
  }

  /* Getter method for state
  PatientStatus getState() {
    return _state;
  }*/

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
      Rastreio.fromJson(json['last_screening']),
      //PatientStatus.fromJson(json['state']),
    );
  }

  static fromJson(json) {}

}
