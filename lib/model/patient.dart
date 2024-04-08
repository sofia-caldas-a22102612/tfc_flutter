import 'package:tfc_flutter/model/gender_type.dart';

class Patient {
  String _id;
  String _name;
  String _cc;
  DateTime _birthDate;
  GenderType _genre;

  Patient(this._id, this._name, this._cc, this._birthDate, this._genre);

  factory Patient.fromJSON(Map<String, dynamic> json) {
    return Patient(json['utente_id'],
      json['utente_nome'],
      json['utente_cc'],
      json['utente_data_nascimento'],
      json['utente_genero'] == '1' ? GenderType.male : GenderType.female,);
  }
}