import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/user.dart';

import '../util/http.dart';

class AuthenticationException implements Exception {}

class ZeusRepository {
  final String? _endpoint = dotenv.env['ZEUS_BASE_URL'];

  String _buildBasicAuth(String email, String password) =>
      base64.encode(utf8.encode('$email:$password'));

  Future<List<Patient>> searchPatients(User sessionOwner, String patientNameOrId) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);

    // como posso receber um id ou um nome, verifico se é um número, para decidir
    var queryType = "nome";
    if (int.tryParse(patientNameOrId) != null) {
      queryType = "id";
    }

    Response response = await http.get(
      Uri.parse("$_endpoint/search?$queryType=$patientNameOrId"),
      headers: {'Authorization': 'Basic $basicAuth'},
    );
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body)['message']['utentes'];
      return result.map((json) => Patient.fromJsonZeus(json)).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }
}
