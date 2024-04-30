import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart' as patient_models;
import 'package:tfc_flutter/patientPages/patientPages.dart';

import '../../../model/session.dart';

class PaginaTratamento extends StatelessWidget {
  const PaginaTratamento({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    // Assuming you have access to the Treatment object for the patient
    final patient_models.Treatment? treatment =
        patient!.getCurrentTreatment(); //todo call api

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Treatment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text(
            //patientPages[1]['title'] as String,
            // Access the title from the list
            //style: TextStyle(fontSize: 30),
            // ),
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
    );
  }
}