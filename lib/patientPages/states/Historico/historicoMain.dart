import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class HistoricoMain extends StatefulWidget {
  HistoricoMain({Key? key}) : super(key: key);

  @override
  State<HistoricoMain> createState() => _HistoricoMainState();
}

class _HistoricoMainState extends State<HistoricoMain> {
  @override
  Widget build(BuildContext context) {
    var appatiteRepository = context.read<AppatiteRepository>();
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    User? user = session.user;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: appatiteRepository.getHistoryByDateTime(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error loading data'));
          } else if (snapshot.data == null) {
            // Check if snapshot data is null

            return Center(child: Text('Sem Historico'));
          } else {
            var tests = snapshot.data!['tests'] as List<String>;
            var treatments = snapshot.data!['treatments'] as List<String>;

            // Combine tests and treatments into a single list
            var historyItems = [...tests, ...treatments];

            return Scaffold(
              body: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: _buildHistoryItem(historyItems[index]),
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

  Widget _buildHistoryItem(String value) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          title: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
