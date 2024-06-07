import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/patient_state.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';
import '../model/TreatmentModel/treatment.dart';
import 'package:http/http.dart' as http;

class AuthenticationException implements Exception {}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class AppatiteRepository {
  final String? _endpoint = dotenv.env['APPATITEREPOSITORY_BASE_URL'];
  final String? _apiKey = dotenv.env['APPATITEREPOSITORY_API_KEY'];

  String _buildBasicAuth(String email, String password) =>
      base64.encode(utf8.encode('$email:$password'));

  Future<List<Patient>> fetchPatientsDaily(User sessionOwner) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final response = await http.get(
      Uri.parse("$_endpoint/patient/activeTreatment"),
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Patient.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<bool> insertNewTest(
    User sessionOwner, {
    bool? result,
    DateTime? resultDate,
    int? testLocation,
    DateTime? testDate,
    required Patient patient,
    int? type,
  }) async {
    final basicAuth = base64Encode(
        utf8.encode('${sessionOwner.userid}:${sessionOwner.password}'));

    Map<String, dynamic> toJson() {
      return {
        'type': type,
        'result': result,
        'resultDate': resultDate?.toIso8601String(),
        'testLocation': testLocation,
        'testDate': testDate?.toIso8601String(),
        'patient': patient.toJson(),
      };
    }

    final requestBody = toJson();

    final http.Response response = await http.post(
      Uri.parse("$_endpoint/tests/new"),
      // Ensure this URL matches your endpoint
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else if (response.statusCode == 404) {
      throw NotFoundException("Resource not found");
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<PatientState?> getPatientState(
      User sessionOwner, Patient patient) async {
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final idZeus = patient.getIdZeus().toString();
    final response = await http.get(
      Uri.parse("$_endpoint/patient/currentStatus?zeusId=$idZeus"),
      headers: {'x-api-token': _apiKey!, 'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return PatientState.fromJson(data);
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<Treatment>> getTreatmentList(
      User sessionOwner, Patient patient) async {
    final zeusId = patient.getIdZeus().toString();
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/treatment/history/$zeusId"),
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

  //todo adicionei ao backend
  Future<Map<String, List<dynamic>>> getCompleteHistory(
      User sessionOwner, Patient patient) async {
    final zeusId = patient.getIdZeus().toString();
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/patient/completeHistory/$zeusId"),
      headers: {'Authorization': 'Basic $basicAuth'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      final List<dynamic>? testsJson = data['tests'];
      final List<dynamic>? treatmentsJson = data['treatments'];

      if (testsJson == null ||
          treatmentsJson == null ||
          testsJson.isEmpty ||
          treatmentsJson.isEmpty) {
        return {
          'message': ['Sem historico']
        };
      }

      final List<dynamic> tests =
          testsJson.map((json) => Test.fromJson(json)).toList();
      final List<dynamic> treatments =
          treatmentsJson.map((json) => Treatment.fromJson(json)).toList();

      return {
        'tests': tests,
        'treatments': treatments,
      };
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<Test>> getTestHistory(User sessionOwner, Patient patient) async {
    final zeusId = patient.getIdZeus().toString();
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final http.Response response = await http.get(
      Uri.parse("$_endpoint/tests/patient/$zeusId"),
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);
      if (responseBody == null || responseBody.isEmpty) {
        return []; // Return an empty list if no tests are found
      } else {
        final List<dynamic> data = responseBody;
        return data.map<Test>((json) => Test.fromJson(json)).toList();
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<Test> getCurrentTest(User sessionOwner, int zeusId) async {
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final response = await http.get(
      Uri.parse("$_endpoint/patient/lastScreening/$zeusId"),
      headers: {
        'x-api-token': '$_apiKey',
        'Authorization': 'Basic $basicAuth',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Test.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception("No last screening found for patient with ID: $zeusId");
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<List<String>> getTreatmentHistory(
      User sessionOwner, Patient patient) async {
    final idZeus = patient.getIdZeus().toString();
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final Response response = await http.get(
      Uri.parse("$_endpoint/state/$idZeus/treatmentHistory"),
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



  Future<bool> updateTest(User sessionOwner, Test test) async {
    final basicAuth =
        _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final response = await http.put(
      Uri.parse("$_endpoint/tests/update/${test.getId()}"),
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(test.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> insertNewTreatment(
      User sessionOwner, {
        required DateTime startDate,
        DateTime? expectedEndDate,
        int? nameMedication,
        required Patient patient,
        int? treatmentDuration,
      }) async {
    final basicAuth =
    _buildBasicAuth(sessionOwner.userid, sessionOwner.password);

    Map<String, dynamic> toJson() {
      return {
        'startDate': startDate.toIso8601String(),
        'expectedEndDate': expectedEndDate?.toIso8601String(),
        'nameMedication': nameMedication,
        'patient': patient.toJson(),
        'treatmentDuration': treatmentDuration,
      };
    }

    final requestBody = toJson();

    final http.Response response = await http.post(
      Uri.parse("$_endpoint/treatment/new"),
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else if (response.statusCode == 404) {
      throw NotFoundException("Resource not found");
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<Treatment?> getCurrentTreatment(User sessionOwner, int zeusId) async {
    final basicAuth = _buildBasicAuth(sessionOwner.userid, sessionOwner.password);
    final response = await http.get(
      Uri.parse("$_endpoint/treatment/current/$zeusId"),
      headers: {
        'x-api-token': _apiKey!,
        'Authorization': 'Basic $basicAuth',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Treatment.fromJson(data);
    } else if (response.statusCode == 404) {
      throw NotFoundException("No current treatment found for patient with ID: $zeusId");
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }
}
