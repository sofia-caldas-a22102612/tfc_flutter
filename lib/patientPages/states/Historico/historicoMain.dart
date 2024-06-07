import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/patientPages/states/testPages/testInfoPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class HistoricoMain extends StatefulWidget {
  HistoricoMain({Key? key}) : super(key: key);

  @override
  State<HistoricoMain> createState() => _HistoricoMainState();
}

class _HistoricoMainState extends State<HistoricoMain> {
  @override
  Widget build(BuildContext context) {
    final appatiteRepository = context.read<AppatiteRepository>();
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    User? user = session.user;

    return Scaffold(
      body: FutureBuilder<List<Test>>(
        future: appatiteRepository.getTestHistory(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error loading data'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Sem Historico'));
          } else {
            var tests = snapshot.data!;

            return Scaffold(
              body: ListView.builder(
                itemCount: tests.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: _buildHistoryItem(context, tests[index]), // Pass context here
                      ),
                      Divider(), // Add Divider after each list item
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, Test test) { // Accept context as parameter
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          title: Text(
            test.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestInfoPage(test: test)), // Navigate to TestInfoPage with test
            );
          },
        ),
      ),
    );
  }
}

class AuthenticationException implements Exception {}
