import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart' as TestModel; // Import the Test class with a prefix
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart' as TreatmentModel;
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart'; // Import the Treatment

class PaginaEditarDiagnostico extends StatefulWidget {
  @override

  _PaginaEditarDiagnosticoState createState() => _PaginaEditarDiagnosticoState();
}

class _PaginaEditarDiagnosticoState extends State<PaginaEditarDiagnostico> {
  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    Patient? patient = session.patient;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Diagnóstico'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Teste Diagnóstico',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              // Your existing UI widgets...
              ElevatedButton(
                onPressed: () {
                  // Create a new Test object

                  TestModel.Test newTest = TestModel.Test(); //todo usar API
                  //appatiteRepo.insertNewTest(newTest);
                  
                  // Add the new Test to the testList of the patient
                  patient!.addTest(newTest);
                  // Navigate to the next page or perform any other action
                },
                child: Text('Guardar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPatientPage(),
                    ),
                  );
                },
                child: Text('Perfil Utente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

