import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/patientPages.dart';

class PaginaTesteDiagnosticoPositivo extends StatelessWidget {
  final Patient patient;

  // Constructor with required patient parameter
  const PaginaTesteDiagnosticoPositivo({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call PatientPages function with the patient parameter to get the list of pages
    List<Map<String, dynamic>> patientPages = PatientPages(patient);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            patientPages[3]['title'] as String, // Access the title from the list
            style: TextStyle(fontSize: 30),
          ), // Display the title with a larger font size
        ],
      ),
    );
  }
}
