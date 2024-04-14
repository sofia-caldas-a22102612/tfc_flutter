import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/rastreio.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart' as treatment_;
import 'package:tfc_flutter/repository/appatite_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// This class is only used for local tests and convenience
class FakeAppatiteRepository extends AppatiteRepository {
  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    return [
      Patient.withDetails(
        '123',
        'Maria',
        '123456789',
        DateTime.parse("1996-01-01"),
        GenderType.male,
        25,
        '123445678',
        null,
        null,
        null,
        1,
        null,
        PatientStatus.NED,
      ),
      Patient.withDetails(
        '12234',
        'Joao',
        '987654321',
        DateTime.parse("1990-05-15"),
        GenderType.female,
        32,
        '456',
        789,
        'last program name',
        DateTime.parse("2022-03-25"),
        2,
        RastreioBuilder()
            .fromParameters(2, '2024-04-13T08:00:00Z', '2024-04-15T08:00:00Z', false, 3)
            .withDiagnosis(true)
            .withType(1)
            .build() as Test?,
        PatientStatus.POSITIVE_DIAGNOSIS,
      ),
    ];
  }

  void newTest(User sessionOwner, Test test) async {
    // Todo: implement this method
  }
}
