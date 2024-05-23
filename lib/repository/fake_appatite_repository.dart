import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import '../model/patient.dart';
import '../model/user.dart';

class FakeAppatiteRepository extends AppatiteRepository {

  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    print('object');
    return [
      Patient(
        1,
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
      Patient(
        2,
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
        Test.rastreio(
          id: 123,
          diagnosis: false,
          type: 1,
          testDate: DateTime.parse('2024-04-13T08:00:00Z'),
          resultDate: DateTime.parse('2024-04-15T08:00:00Z'),
          result: true,
        ),

        PatientStatus.POSITIVE_DIAGNOSIS,
      ),
    ];
  }



  Future<List<Patient>> fetchPatientsDailyTest() async {
    return [
      Patient.withDetails(
        1,
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
        2,
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
        Test.rastreio(
          id: 123,
          diagnosis: false,
          type: 1,
          testDate: DateTime.parse('2024-04-13T08:00:00Z'),
          resultDate: DateTime.parse('2024-04-15T08:00:00Z'),
          result: true,
        ),
        PatientStatus.POSITIVE_DIAGNOSIS,
      ),
    ];
  }

  void newTest(User sessionOwner, Test test) async {
    // Todo: implement this method
  }


  Future<String> getPatientState(User sessionOwner, Patient patient) async {
    final patientState = patient.getPatientStateString(); // Assuming getStatus() returns the patient state directly
    print('Patient State: $patientState'); // Debug print
    return patientState;
  }



  Future<List<String>> getHistoryByDateTime(User sessionOwner, Patient patient) async {
    List<String> history = [
      'History item 1',
      'History item 2',
      'History item 3',
    ];
    return history;
  }

  Future<List<String>> getTestHistory(User sessionOwner, Patient patient) async {
    List<String> testHistory = [
      'Test 1',
      'Test 2',
      'Test 3',
    ];

    //todo alter backend
    return testHistory;
  }

   Future<List<String>> getTreatmentHistory(User sessionOwner, Patient patient) async {
    List<String> treatmentHistory = [
      'Treatment 1',
      'Treatment 2',
      'Treatment 3',
    ];

    //todo alter backend
    return treatmentHistory;
  }


}
