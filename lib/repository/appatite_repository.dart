import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:http/http.dart' as http;
import '../model/TreatmentModel/treatment.dart';

class AuthenticationException implements Exception {}

class AppatiteRepository {
  final String? _endpoint = dotenv.env['APPATITEREPOSITORY_BASE_URL'];

  String _buildBasicAuth(String email, String password) =>
      base64.encode(utf8.encode('$email:$password'));

  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await get(
      Uri.parse("$_endpoint/api/patient/activeTreatment"),
      headers: {'Authorization': 'Basic $basicAuth'},
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

  Future<List<Patient>> insertNewTest(User sessionOwner, Test newTest) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Map<String, dynamic> requestBody = newTest.toJson();

    final Response response = await post(
      Uri.parse("$_endpoint/new"),
      headers: {
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
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

  Future<String?> getPatientState(User sessionOwner, Patient patient) async {
    final id = patient.getId().toString();
    final Response response = await get(
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


  Future<List<Treatment>?> getTreatmentList(User sessionOwner, Patient patient) async {
    final String id = patient.getId().toString();
    final String baseUrl = '$_endpoint/state/$id';

    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['message'].toUpperCase();
      } else if (response.statusCode == 401) {
        throw AuthenticationException();
      } else {
        throw Exception("${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }


}
