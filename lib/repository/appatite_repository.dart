import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';
import '../model/TreatmentModel/treatment.dart';
import '../util/http.dart';

class AuthenticationException implements Exception {}

class AppatiteRepository {
  final String? _endpoint = dotenv.env['APPATITEREPOSITORY_BASE_URL'];
  final String? _apiKey = dotenv.env['APPATITEREPOSITORY_API_KEY'];

  String _buildBasicAuth(String email, String password) =>
      base64.encode(utf8.encode('$email:$password'));

  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/api/patient/activeTreatment"),
      headers: {'x-api-token': '$_apiKey', 'Authorization': 'Basic $basicAuth'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body)['message'];
      return result.map((json) => Patient.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<bool> insertNewTest(User sessionOwner, Test newTest, Patient patient) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);

    final Map<String, dynamic> requestBody = {
      'diagnosis': newTest.diagnosis,
      'type': newTest.type,
      'result': newTest.result,
      'resultDate': newTest.resultDate?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'testLocation': newTest.testLocation,
      'testDate': newTest.testDate!.toIso8601String(), // Convert DateTime to ISO 8601 string
      'patient': patient.toJson(), // Convert Patient object to JSON using its toJson method
      'patientStatus': patient.getPatientState()!.index, // Access patientStatus using the getter
    };

    final Response response = await http.post(
      Uri.parse("$_endpoint/tests/new"),
      headers: {
        'x-api-token': '$_apiKey',
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }


  Future<String?> getPatientState(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$id"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['message'].toUpperCase();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<Treatment>> getTreatmentList(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$id/treatments"),
      headers: {'x-api-token': '$_apiKey', 'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['message'];
      return data.map((json) => Treatment.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<String>> getHistoryByDateTime(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$id/history"),
      headers: {'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['message'];
      return data.map((json) => json.toString()).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<String>> getTestHistory(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$id/testHistory"),
      headers: {'x-api-token': '$_apiKey', 'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['message'];
      return data.map((json) => json.toString()).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<String>> getTreatmentHistory(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$id/treatmentHistory"),
      headers: {'x-api-token': '$_apiKey', 'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['message'];
      return data.map((json) => json.toString()).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }


  //todo get rid of this and fetch state from API


}
