import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class HistoricoTestes extends StatefulWidget {
  HistoricoTestes({Key? key}) : super(key: key);

  @override
  State<HistoricoTestes> createState() => _HistoricoTestesState();
}

class _HistoricoTestesState extends State<HistoricoTestes> {
  @override
  Widget build(BuildContext context) {
    var appatiteRepository = context.read<AppatiteRepository>();
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    User? user = session.user;

    return Scaffold(
      body: FutureBuilder<List<Test>>(
        future: appatiteRepository.getTestHistory(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            print(snapshot.error);
            print('STOP');
            return Center(child: Text('Error loading data'));
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
                        child: _buildHistoryItem(tests[index]),
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

  Widget _buildHistoryItem(Test test) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          title: Text(
            // Assuming test has a property called testDate
            test.getTestDate.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // You can display other details of the test here
        ),
      ),
    );
  }
}
