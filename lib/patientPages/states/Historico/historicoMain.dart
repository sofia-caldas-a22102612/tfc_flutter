import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';
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
      body: FutureBuilder(
        future: appatiteRepository.getHistoryByDateTime(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            print(snapshot.error);
            print('STOP');
            return Center(child: Text('Error loading data'));
          } else {
            var data = snapshot.data as List<String>;

            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoricoMain(),
                            ),
                          );
                          print('Result from PaginaTratamento: $result');
                        },
                        child: Row(
                          children: [
                            _buildHistoryItem(data[index]),
                            _buildHistoryItem(data[index]),
                            _buildHistoryItem(data[index])
                          ],
                        ),
                      ),
                      separatorBuilder: (_, index) =>
                          Divider(color: Colors.grey, thickness: 1),
                      itemCount: data.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryItem(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        title: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
