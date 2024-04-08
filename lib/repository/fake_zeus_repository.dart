import 'dart:ffi';

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
          PatientStatus.NED,
        ),

    Patient(
    'paciente 2', // _id
    'nome 2', // _name
    '987654321', // _cc
    DateTime.parse("1990-05-15"), // _birthDate
    GenderType.female, // _gender
    32, // _age
    456, // _realId
    789, // _documentType
    'last program name', // _lastProgramName
    DateTime.parse("2022-03-25"), // _lastProgramDate
    2, // _userId
    null, // _lastScreening
    PatientStatus.NED, // _state
    ),

    ];
    } else {
      throw AuthenticationException();
    }
  }

  Future<List<Patient>> searchPatientsTest(String patientName) async {
    final List<Patient> patients = [
      Patient(
        '123', // _id
        'Maria', // _name
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
        PatientStatus.NED,
      ),
      Patient(
        '12234', // _id
        'Joao', // _name
        '987654321', // _cc
        DateTime.parse("1990-05-15"), // _birthDate
        GenderType.female, // _gender
        32, // _age
        456, // _realId
        789, // _documentType
        'last program name', // _lastProgramName
        DateTime.parse("2022-03-25"), // _lastProgramDate
        2, // _userId
        null, // _lastScreening
        PatientStatus.NED, // _state
      ),
    ];

    // Filter patients based on matching ID or partially matching name
    List<Patient> filteredPatients = patients.where((patient) {
      // Check if the patientName contains only numbers
      if (_containsOnlyNumbers(patientName)) {
        // Search by ID
        return patient.getId() == patientName;
      } else {
        // Search by partially matching name
        return patient.getName().toLowerCase().contains(patientName.toLowerCase());
      }
    }).toList();

    return filteredPatients;
  }


// Function to check if a string contains only numbers
  bool _containsOnlyNumbers(String value) {
    final RegExp regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(value);
  }


}