import 'package:flutter/foundation.dart';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// this class is only used for local tests and convenience
class FakeZeusRepository extends ZeusRepository {

  Future<List<Patient>> searchPatients(User sessionOwner, String patientName) async {

    debugPrint('FakeZeusRepository - search: $patientName');

    if (sessionOwner.userid == 'user' && sessionOwner.password == 'password') {
      return [
        Patient.fromZeus(
          1, // _id
          'nome 1', // _name
          '123456789', // _cc
          DateTime.parse("1996-01-01"), // _birthDate
          GenderType.male, // _genre
          '1234', // _realId
          null, // _documentType
          null, // _lastProgramName
          null, // _lastProgramDate
          1, // _userId
          //null, // _lastScreening
          //PatientStatus.NED,
        ),

    Patient.fromZeus(  //todo adicionei este builder devido ao estado nao existir no zeus
    2, // _id
    'nome 2', // _name
    '987654321', // _cc
    DateTime.parse("1990-05-15"), // _birthDate
    GenderType.female, // _gender
    '456', // _realId
    789, // _documentType
    'last program name', // _lastProgramName
    DateTime.parse("2022-03-25"), // _lastProgramDate
    2, // _userId
    //null, // _lastScreening
    //PatientStatus.NED, // _state //
    ),

    ];
    } else {
      throw AuthenticationException();
    }
  }



// Function to check if a string contains only numbers
  bool _containsOnlyNumbers(String value) {
    final RegExp regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(value);
  }


}