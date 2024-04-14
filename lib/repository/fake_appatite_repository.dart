import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/rastreio.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/treatment.dart' as treatment_;
import 'package:tfc_flutter/repository/appatite_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// this class is only used for local tests and convenience
class FakeAppatiteRepository extends AppatiteRepository {

  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    return [
      Patient(
          '123',
          // _id
          'Maria',
          // _name
          '123456789',
          // _cc
          DateTime.parse("1996-01-01"),
          // _birthDate
          GenderType.male,
          // _genre
          25,
          // _age
          123445678,
          // _realId
          null,
          // _documentType
          null,
          // _lastProgramName
          null,
          // _lastProgramDate
          1,
          // _userId
          null,
          PatientStatus.NED // _lastScreening
      ),

      Patient(
          '12234',
          // _id
          'Joao',
          // _name
          '987654321',
          // _cc
          DateTime.parse("1990-05-15"),
          // _birthDate
          GenderType.female,
          // _genre
          32,
          // _age
          456,
          // _realId
          789,
          // _documentType
          'last program name',
          // _lastProgramName
          DateTime.parse("2022-03-25"),
          // _lastProgramDate
          2,
          // _userId
          RastreioBuilder()
              .fromParameters(
              2, '2024-04-13T08:00:00Z', '2024-04-15T08:00:00Z', false, 3)
              .withDiagnosis(true)
              .withType(1)
              .build() as treatment_.Test?,
          PatientStatus.POSITIVE_DIAGNOSIS

        // _lastScreening todo add screening
      ),

    ];
  }






  void newTest(User sessionOwner, Test test) async {
  //todo return state
  }

}