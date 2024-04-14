import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/patientPages/states/rastreio/novoRastreio.dart';

import '../../patientPages.dart';


class PaginaNED extends StatelessWidget {
  
  const PaginaNED({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    Patient? patient = session.patient;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Resultado do Último Rastreio: ' +
                'negativo',
            style: TextStyle(color: Colors.black26, fontSize: 30),
          ),
        ),
        Expanded(child: Container()), // Add empty container to push button to the bottom
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: () {
              // Navigate to the NovoRastreio page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPatientPage(), // todo change patient state
                ),
              );
            },
            child: Text('Adicionar Novo Rastreio'),
          ),
        ),
      ],
    );
  }
}
