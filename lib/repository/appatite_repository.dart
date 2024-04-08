import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/test.dart';

class AppatiteRepository {
  static const String _baseUrl = 'https://example.com/api'; // Replace with your API base URL

  Future<List> fetchPatientsDaily() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/patient/activeTreatment'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<Patient> jsonList = jsonData['patients']; // Assuming 'patients' is the key containing the list of patient data
        return jsonList.map((json) => Patient.fromJson(json)).toList();

      } else {
        throw Exception('Failed to fetch patients. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch patients: $e');
    }
  }

  static Future<List> searchPatients(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/patient/search/$query'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Patient.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search patients. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search patients: $e');
    }
  }

  static Future<Patient> updatePatient(String patientId) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/patient/$patientId'), // Use the provided 'patientId' parameter
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Patient.fromJson(jsonData); // Assuming server returns the updated patient object
      } else {
        throw Exception('Failed to update patient. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }


  Future<Test> addDiagnosisTest(int testId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/tests/new'),
        body: json.encode({'testId': testId}), // Provide testId in the request body
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Test.fromJson(jsonData); // Assuming server returns a single test object
      } else {
        throw Exception('Failed to add test. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add test: $e');
    }
  }


  Future<Test> getTest(int testId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/tests/$testId'), // Adjust URI to fetch test by ID
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Test.fromJson(jsonData); // Assuming server returns a single test object
      } else {
        throw Exception('Failed to get test. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get test: $e');
    }
  }

  Future<Test> updateTest(int testId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/tests/$testId'), // Adjust URI to fetch test by ID
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Test.fromJson(jsonData); // Assuming server returns a single test object
      } else {
        throw Exception('Failed to get test. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get test: $e');
    }
  }




}
