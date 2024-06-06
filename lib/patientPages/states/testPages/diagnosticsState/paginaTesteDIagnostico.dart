import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/patient_state.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
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
    final user = session.user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<PatientState?>(
                future: appatiteRepository.getPatientState(session.user!, patient!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final patientState = snapshot.data!;
                    if (patientState.status == PatientStatus.POSITIVE_DIAGNOSIS.name) {
                      return FutureBuilder<Test>(
                        future: appatiteRepository.getCurrentTest(session.user!, patient.getIdZeus()),
                        builder: (context, testSnapshot) {
                          if (testSnapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (testSnapshot.hasError || testSnapshot.data == null) {
                            return Text('Error fetching test data');
                          } else {
                            final test = testSnapshot.data!;
                            return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return TestWidget(test: test);
                              },
                            );
                          }
                        },
                      );
                    } else if (patientState.status == PatientStatus.POSITIVE_SCREENING.name) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle the action for starting a new screening
                        },
                        child: Text('Novo Diagnóstico'),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appatiteRepository.updatePatientStatus(user!, patient.getIdZeus(), PatientStatus.TREATMENT.name);
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
  final Test test;

  const TestWidget({Key? key, required this.test}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Test Type: ${test.getTypeString()}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Test Date: ${test.getTestDate().toString()}'),
          Text('Result: ${test.getResult() ?? ''}'),
        ],
      ),
    );
  }
}
