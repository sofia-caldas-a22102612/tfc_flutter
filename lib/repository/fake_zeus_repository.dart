import 'package:flutter/foundation.dart';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// this class is only used for local tests and convenience
class FakeZeusRepository extends ZeusRepository {
  final fakePatients = [
    Patient.fromZeus(
        1,
        // _id
        'Maria Fernanda Silva',
        // _name
        '1234567890',
        // _cc
        DateTime.parse("1985-05-15"),
        // _birthDate
        GenderType.female,
        // _genre
        '1234567890',
        // _realId
        'Cartão de Cidadão',
        // _documentType
        'Metadona',
        // _lastProgramName
        DateTime.parse("2023-01-10") // _lastProgramDate
        ),
    Patient.fromZeus(
        2,
        // _id
        'Maria José Ramos',
        // _name
        '9876543210',
        // _cc
        DateTime.parse("1992-07-24"),
        // _birthDate
        GenderType.female,
        // _genre
        '9876543210',
        // _realId
        'Cartão de Cidadão',
        // _documentType
        null,
        // _lastProgramName
        null // _lastProgramDate
        ),
    Patient.fromZeus(
        3,
        // _id
        'Maria Clara Gomes',
        // _name
        null,
        // _cc
        DateTime.parse("1979-11-30"),
        // _birthDate
        GenderType.female,
        // _genre
        '3CF5663FG',
        // _realId
        'Passaporte',
        // _documentType
        null,
        // _lastProgramName
        null // _lastProgramDate
        ),
    Patient.fromZeus(
        4,
        // _id
        'Carlos Eduardo Peixoto',
        // _name
        '1928374650',
        // _cc
        DateTime.parse("1990-03-21"),
        // _birthDate
        GenderType.male,
        // _genre
        '1928374650',
        // _realId
        'Cartão de Cidadão',
        // _documentType
        null,
        // _lastProgramName
        null // _lastProgramDate
        ),
    Patient.fromZeus(
        5,
        // _id
        'Carlos Martins Lopes',
        // _name
        null,
        // _cc
        DateTime.parse("1980-12-10"),
        // _birthDate
        GenderType.male,
        // _genre
        '5647382910FGH',
        // _realId
        'Passaporte',
        // _documentType
        null,
        // _lastProgramName
        null // _lastProgramDate
        )
  ];

  Future<List<Patient>> searchPatients(User sessionOwner, String patientName) async {
    debugPrint('FakeZeusRepository - search: $patientName');

    if (sessionOwner.userid == 'user' && sessionOwner.password == 'password') {
      return fakePatients
          .where((patient) => patient.getName().toLowerCase().contains(patientName.toLowerCase()))
          .toList();
    } else {
      throw AuthenticationException();
    }
  }
}
