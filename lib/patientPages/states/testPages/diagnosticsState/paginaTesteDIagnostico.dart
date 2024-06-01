import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/patientPages/states/testPages/diagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class PaginaTesteDiagnostico extends StatefulWidget {
  const PaginaTesteDiagnostico({Key? key}) : super(key: key);

  @override
  _PaginaTesteDiagnosticoState createState() => _PaginaTesteDiagnosticoState();
}

class _PaginaTesteDiagnosticoState extends State<PaginaTesteDiagnostico> {

  @override
  Widget build(BuildContext context) {
    final session = context.read<Session>();
    final appatiteRepository = context.read<AppatiteRepository>();
    final patient = session.patient;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<String?>(
                future: appatiteRepository.getPatientState(session.user!, patient!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Data has been received successfullynão t
                    final patientState = snapshot.data!;
                    if (patientState == PatientStatus.POSITIVE_DIAGNOSIS.name) {
                      // Render the list of tests
                      return ListView.builder(
                        itemCount: 10, // Replace 10 with the actual number of tests
                        itemBuilder: (context, index) {
                          // Replace TestWidget with the widget to display each test
                          return TestWidget(testData: 'Test ${index + 1}');
                        },
                      );
                    } else if (patientState == PatientStatus.POSITIVE_SCREENING.toString()) {
                      // Render the button only if patient status is "TREATMENT"
                      return ElevatedButton(
                        onPressed: () {
                          // Handle the action for starting a new screening
                        },
                        child: Text('Novo Diagnóstico'),
                      );
                    } else {
                      // Render an empty container if patient status is not "TREATMENT" or "POSITIVE_DIAGNOSIS"
                      return SizedBox.shrink();
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Change the PatientState to indicate treatment has started
                patient.updatePatientState(PatientStatus.TREATMENT);
                // Navigate to the main patient page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPatientPage(),
                  ),
                );
              },
              child: Text('Começar Tratamento'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String testData;

  const TestWidget({Key? key, required this.testData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(testData),
      // Add more widgets to display additional test information
    );
  }
}
