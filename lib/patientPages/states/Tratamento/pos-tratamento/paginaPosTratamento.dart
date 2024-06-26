import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/states/testPages/novoTeste.dart';


class PaginaPosTratamento extends StatelessWidget {
  final Patient patient;

  const PaginaPosTratamento({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final session = context.watch<Session>();
    Patient? patient = session.patient;

    return Scaffold( // Add Scaffold widget
      appBar: AppBar( // Add AppBar
        title: Text('Pos Tratamento'), // Set app bar title
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'A Aguadar Teste Diagnóstico',
              style: TextStyle(color: Colors.black26, fontSize: 30),
            ),
          ),
          Expanded(child: Container()), // Add empty container to push button to the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NovoTeste(),
                  ),
                );
              },
              child: Text('Adicionar Teste'),
            ),
          ),
        ],
      ),
    );
  }
}
