import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/user.dart';

class AuthenticationException implements Exception {}

class ZeusRepository {

  final String? _endpoint = dotenv.env['ZEUS_BASE_URL'];

  String _buildBasicAuth(String email, String password) => base64.encode(utf8.encode('$email:$password'));

  Future<List<Patient>> searchPatients(User sessionOwner, String patientName) async {

    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    Response response = await get(
      Uri.parse("$_endpoint/search?nome=$patientName"),
      headers: {'Authorization': 'Basic $basicAuth'},
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
}