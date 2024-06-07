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
            return Center(child: Text('Sem Histórico'));
          } else {
            var tests = snapshot.data!;

            return ListView.builder(
              itemCount: tests.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: _buildHistoryItem(context, tests[index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, Test test) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestInfoPage(test: test)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Test Type: ${test.getTypeString()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Test Date: ${test.getTestDate().toString()}'),
              Text('Result: ${test.getResult() ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthenticationException implements Exception {}
