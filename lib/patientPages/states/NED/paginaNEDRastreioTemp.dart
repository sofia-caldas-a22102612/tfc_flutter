import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/states/rastreio/novoRastreio.dart';

import '../../patientPages.dart';


class PaginaNED extends StatelessWidget {
  final Patient patient;

  // Constructor with required patient parameter
  const PaginaNED({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call PatientPages function with the patient parameter to get the list of pages
    List<Map<String, dynamic>> patientPages = PatientPages(patient);

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
                  builder: (context) => NovoRastreio(patient: patient), // Navigate to the NovoRastreio page
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
