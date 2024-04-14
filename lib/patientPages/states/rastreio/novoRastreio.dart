import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart' as TestModel; // Import the Test class with a prefix
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart' as TreatmentModel;
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

import '../../../model/user.dart';

class NovoRastreio extends StatefulWidget {
  const NovoRastreio({super.key});

  @override
  _NovoRastreioState createState() => _NovoRastreioState();
}

class _NovoRastreioState extends State<NovoRastreio> {

  bool? diagnosis;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;

  // Method to create a new Rastreio object
  TestModel.Test createRastreio(Patient patient) {
    return TestModel.Test(
      diagnosis: diagnosis,
      testDate: testDate,
      resultDate: resultDate,
      result: result,
      testLocation: testLocation,
      patient: patient, // Assign the patient to the created Rastreio
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    Patient? patient = session.patient;
    User? user = session.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Rastreio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teste Rastreio',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Test Date'),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    setState(() {
                      testDate = DateTime.tryParse(value);
                      diagnosis = false;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Result Date'),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    setState(() {
                      resultDate = DateTime.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Result'),
                  onChanged: (value) {
                    setState(() {
                      result = value.isNotEmpty ? value == 'true' : null;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Test Location'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      testLocation = int.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (diagnosis == true) {
                      // Create a new Rastreio object
                      TestModel.Test newRastreio = createRastreio(patient!);
                      // Add the new Rastreio to the patient
                      patient!.addRastreio(newRastreio); //todo remove this
                      patient!.addTest(newRastreio);

                      //todo usar API
                      appatiteRepo.insertNewTest(user!, newRastreio);
                      // Change the patient state to POSITIVE_SCREENING_DIAGNOSIS
                      patient.updatePatientState(PatientStatus.POSITIVE_SCREENING_DIAGNOSIS);//todo usar API

                      // Navigate to the edit diagnosis page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaginaEditarDiagnostico(),
                        ),
                      );
                    } else {
                      // If the diagnosis is negative, navigate back to the previous page
                      Navigator.pop(context);
                    }

                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
