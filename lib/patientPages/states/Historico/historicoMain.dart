import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/user.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        future: getHistoryByDateTime(user!, patient!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error loading data'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Sem Historico'));
          } else {
            var tests = snapshot.data!['tests'] as List<dynamic>;
            var treatments = snapshot.data!['treatments'] as List<dynamic>;

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

  Widget _buildHistoryItem(dynamic value) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          title: Text(
            value.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getHistoryByDateTime(User sessionOwner, Patient patient) async {
    final id = patient.getIdZeus().toString();
    final basicAuth = 'Basic ' + base64Encode(utf8.encode('${sessionOwner.userid}:${sessionOwner.password}'));
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/patient/completeHistory/$id"),
      headers: {'Authorization': basicAuth},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw AuthenticationException();
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }
}

class AuthenticationException implements Exception {}
