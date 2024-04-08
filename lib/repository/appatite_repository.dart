import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tfc_flutter/model/patient.dart';

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
}
