import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../model/patient.dart';
import '../model/user.dart';

// this class is only used for local tests and convenience
class FakeZeusRepository extends ZeusRepository {

  Future<List<Patient>> searchPatients(User sessionOwner, String patientName) async {
    if (sessionOwner.userid == 'admin' && sessionOwner.password == '123') {
      return [
        Patient('paciente 1', 'nome 1', '123456789', DateTime.parse("1996-01-01"), GenderType.male),
        Patient('paciente 2', 'nome 2', '200000000', DateTime.parse("1992-07-15"), GenderType.female),
      ];
    } else {
      throw AuthenticationException();
    }
  }
}