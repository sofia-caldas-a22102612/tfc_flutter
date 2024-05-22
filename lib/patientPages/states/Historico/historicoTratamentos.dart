import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/user.dart';

import 'package:tfc_flutter/repository/appatite_repository.dart';

class HistoricoTratamentos extends StatefulWidget {
  HistoricoTratamentos({Key? key}) : super(key: key);

  @override
  State<HistoricoTratamentos> createState() => _HistoricoTratamentosState();
}

class _HistoricoTratamentosState extends State<HistoricoTratamentos> {
  @override
  Widget build(BuildContext context) {
    var appatiteRepository = context.read<AppatiteRepository>();
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    User? user = session.user;

    return Scaffold(
      body: FutureBuilder(
        future: appatiteRepository.getTreatmentHistory(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            print(snapshot.error);
            print('STOP');
            return Center(child: Text('Error loading data'));
          } else {
            var data = snapshot.data as List<String>;

            return Scaffold(
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: _buildHistoryItem(data[index]),
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
