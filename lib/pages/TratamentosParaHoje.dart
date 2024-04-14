import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';

import '../model/session.dart';

class TratamentosParaHoje extends StatefulWidget {
  const TratamentosParaHoje({Key? key});

  @override
  _TratamentosParaHojeState createState() => _TratamentosParaHojeState();
}

class _TratamentosParaHojeState extends State<TratamentosParaHoje> {
  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    var user = session.user;
    var appatiteRepository = context.read<AppatiteRepository>();

    return Scaffold(
      body: FutureBuilder(
        future: appatiteRepository.fetchPatientsDaily(user!),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            var patients = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0), // Larger top padding
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                         session.patient = patients[index];
                          //todo fazer update do patient na classe sessao
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPatientPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 8), // Add spacing between icon and text
                            Expanded(
                              child: Text(
                                patients[index].getName(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Show popup when button is clicked
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmar Toma'),
                                      content:  TextButton(
                                        onPressed: () {
                                          // Add action for dark green button
                                          Navigator.pop(context); // Close the popup
                                        },
                                        child: Text(
                                          'Confirmar Toma',
                                          style: TextStyle(
                                            color: Colors.white, // White color
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.green[900], // Dark green color
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); // Close the popup
                                          },
                                          child:  Text(
                                            'Fechar',
                                            style: TextStyle(
                                              color: Colors.white, // White color
                                            ),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.red[900], // Dark green color
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Registar Toma',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (_, index) => Divider(color: Colors.grey, thickness: 1),
                      itemCount: patients.length,
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
}
