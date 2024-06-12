import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class PaginaEditarDiagnostico extends StatefulWidget {
  const PaginaEditarDiagnostico({Key? key}) : super(key: key);

  @override
  _PaginaEditarDiagnosticoState createState() => _PaginaEditarDiagnosticoState();
}

class _PaginaEditarDiagnosticoState extends State<PaginaEditarDiagnostico> {
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
                    return SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final patientState = snapshot.data!;
                    if (patientState.status == PatientStatus.POSITIVE_DIAGNOSIS.name) {
                      return FutureBuilder<Test>(
                        future: appatiteRepository.getCurrentTest(session.user!, patient.getIdZeus()),
                        builder: (context, testSnapshot) {
                          if (testSnapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(),
                            );
                          } else if (testSnapshot.hasError || testSnapshot.data == null) {
                            return Text('Error fetching test data');
                          } else {
                            final test = testSnapshot.data!;
                            return ListView(
                              children: [
                                TestWidget(test: test, appatiteRepository: appatiteRepository, user: user!),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    final success = await appatiteRepository.updateTest(user, test);
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Test updated successfully')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to update test')),
                                      );
                                    }
                                  },
                                  child: Text('Guardar'),
                                ),
                              ],
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

class TestWidget extends StatefulWidget {
  final Test test;
  final AppatiteRepository appatiteRepository;
  final User user;

  const TestWidget({Key? key, required this.test, required this.appatiteRepository, required this.user}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _testDateController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeController.text = widget.test.getTypeString();
    _testDateController.text = widget.test.getTestDate().toString();
    _resultController.text = widget.test.getResult() as String;
  }

  @override
  void dispose() {
    _typeController.dispose();
    _testDateController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: TextFormField(
            controller: _typeController,
            decoration: InputDecoration(
              labelText: 'Test Type',
              suffixIcon: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Enable editing if needed
                },
              ),
            ),
          ),
        ),
        ListTile(
          title: TextFormField(
            controller: _testDateController,
            decoration: InputDecoration(
              labelText: 'Test Date',
              suffixIcon: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Enable editing if needed
                },
              ),
            ),
          ),
        ),
        ListTile(
          title: TextFormField(
            controller: _resultController,
            decoration: InputDecoration(
              labelText: 'Result',
              suffixIcon: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Enable editing if needed
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
