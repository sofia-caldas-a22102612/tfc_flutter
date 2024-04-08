import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// this class is only used for local tests and convenience
class FakeZeusRepository extends ZeusRepository {

  Future<List<Patient>> searchPatients(User sessionOwner, String patientName) async {
    if (sessionOwner.userid == 'admin' && sessionOwner.password == '123') {
      return [
        Patient(
          'paciente 1', // _id
          'nome 1', // _name
          '123456789', // _cc
          DateTime.parse("1996-01-01"), // _birthDate
          GenderType.male, // _genre
          25, // _age
          null, // _realId
          null, // _documentType
          null, // _lastProgramName
          null, // _lastProgramDate
          1, // _userId
          null, // _lastScreening
        ),

        Patient(
          'paciente 2', // _id
          'nome 2', // _name
          '987654321', // _cc
          DateTime.parse("1990-05-15"), // _birthDate
          GenderType.female, // _genre
          32, // _age
          456, // _realId
          789, // _documentType
          'last program name', // _lastProgramName
          DateTime.parse("2022-03-25"), // _lastProgramDate
          2, // _userId
          null, // _lastScreening todo add screening
        ),
      ];
    } else {
      throw AuthenticationException();
    }
  }
}