import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/treatment.dart' as patient_models;
import 'package:tfc_flutter/patientPages/patientPages.dart';

class PaginaTratamento extends StatelessWidget {
  final Patient patient;

  const PaginaTratamento({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the PatientPages function to get the list of pages
    final patientPages = PatientPages(patient);

    // Assuming you have access to the Treatment object for the patient
    final patient_models.Treatment? treatment = patient.getCurrentTreatment();

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Treatment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              patientPages[1]['title'] as String,
              // Access the title from the list
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            if (treatment != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Date: ${treatment.startDate ?? 'N/A'}'),
                  Text('End Date: ${treatment.realEndDate ?? 'N/A'}'),
                  Text('Medication Name: ${treatment.nameMedication ?? 'N/A'}'),
                ],
              ),
            ] else ...[
              Text('No treatment information available'),
            ],
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1, // Assuming the index of this page in the navigation bar is 1
        onDestinationSelected: (index) {
          // Handle navigation here
        },
        destinations: patientPages.map((page) => NavigationDestination(
          icon: Icon(page['icon'] as IconData),
          label: page['title'] as String,
        )).toList(),
      ),
    );
  }
}
