import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/patient_state.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/novoTratamento.dart';
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
      body: FutureBuilder<Test?>(
        future: appatiteRepository.getCurrentTest(user!, patient!.getIdZeus()),
        builder: (context, testSnapshot) {
          if (testSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (testSnapshot.hasError) {
            return Center(child: Text('Error fetching test data: ${testSnapshot.error}'));
          } else if (!testSnapshot.hasData || testSnapshot.data == null) {
            return Center(child: Text('No test data found'));
          } else {
            final test = testSnapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return TestWidget(test: test);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NovoTratamento(),
                        ),
                      );
                    },
                    child: Text('Começar Tratamento'),
                  ),
                ),
              ],
            );
          }
        },
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
