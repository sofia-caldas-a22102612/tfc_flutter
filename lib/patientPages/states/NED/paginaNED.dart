import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/pages/main.page.dart';
import 'package:tfc_flutter/patientPages/states/testPages/rastreio/novoRastreio.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import 'package:intl/intl.dart';

import '../../patientPages.dart';

class PaginaNED extends StatefulWidget {
  // Constructor with required patient parameter
  const PaginaNED({super.key});

  @override
  _PaginaNEDState createState() => _PaginaNEDState();
}

class _PaginaNEDState extends State<PaginaNED> {

  Widget _buildContent(Enum status, DateTime? statusDate) {
    switch (status) {
      case PatientStatus.NOT_IN_DATABASE:
        return Center(
          child: Text(
            'Este utente ainda não realizou nenhum rastreio',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        );
      case PatientStatus.NED:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resultado do Último Rastreio',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                DateFormat('yyyy-MM-dd HH:mm').format(statusDate!),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 16), // Add some space between the boxes
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Text(
                  'Negativo',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final patient = session.patient;
    final user = session.user;

    // Check the patient's status
    var status = patient!.getPatientState();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContent(status as Enum, patient.patientStatusDate),
              SizedBox(height: 32), // Add spacing before the button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    // Navigate to the NovoRastreio page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovoRastreio(), // change PatientState
                      ),
                    );
                  },
                  child: Text('Adicionar Novo Rastreio'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}