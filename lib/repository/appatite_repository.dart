import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';

class AuthenticationException implements Exception {}


class AppatiteRepository {

  final String? _endpoint = dotenv.env['APPATITEREPOSITORY_BASE_URL'];

  String _buildBasicAuth(String email, String password) =>
      base64.encode(utf8.encode('$email:$password'));


  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    final basicAuth = _buildBasicAuth(
        sessionOwner.userid, sessionOwner.password);
    Response response = await get(
      Uri.parse("$_endpoint/api/patient/activeTreatment"),
      headers: {'Authorization': 'Basic $basicAuth'},
    );
    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      List<Map<String, dynamic>> utentesJson = result['message'];
      return utentesJson.map((utenteJSON) => Patient.fromJSON(utenteJSON))
          .toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }


  Future<List<Patient>> insertNewTest(User sessionOwner, Test newTest) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Map<String, dynamic> requestBody = {
      'diagnosis': newTest.diagnosis,
      'type': newTest.type,
      'result': newTest.result,
      'resultDate': newTest.resultDate.toString(),
      'testLocation': newTest.testLocation,
      'patientId': newTest.patient.toString(),
      'testDate': newTest.testDate.toString(),
      'patient': {
        'name': newTest.patient!.getName(),
        'birthDate': newTest.patient!.getBirthdate().toString(),
        'age': newTest.patient!.getAge(),
        'realId': newTest.patient!.getRealId().toString(),
        'documentType': newTest.patient!.getDocumentType().toString(),
        'lastProgramName': newTest.patient!.getLastProgramName.toString(),
        'userId': newTest.patient!.getUserId().toString()
      }
    };

    final Response response = await post(
      Uri.parse("$_endpoint/new"),
      headers: {
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      List<Map<String, dynamic>> utentesJson = result['message'];
      return utentesJson.map((utenteJSON) => Patient.fromJSON(utenteJSON)).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }



  Future<PatientStatus> getPatientState(User sessionOwner, Patient patient) async {
    final id = patient.getId().toString();
    final Response response = await get(
      Uri.parse("$_endpoint/state/$id"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return PatientStatus.values.firstWhere(
            (status) => status.toString() == data['message'],
        orElse: () => throw Exception('Invalid patient state'),
      );
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }
}

