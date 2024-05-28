import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/pages/main.page.dart';
import 'package:tfc_flutter/patientPages/states/testPages/rastreio/novoRastreio.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

import '../../patientPages.dart';

class PaginaNED extends StatefulWidget {
  // Constructor with required patient parameter
  const PaginaNED({super.key});

  @override
  _PaginaNEDState createState() => _PaginaNEDState();
}

class _PaginaNEDState extends State<PaginaNED> {
  Widget _buildContent(Enum status) {
    switch (status) {
      case PatientStatus.NOT_IN_DATABASE:
        return Center(
          child: Text(
            'Dados não estão na database',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        );
      case PatientStatus.NED:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Resultado do Último Rastreio',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(height: 16), // Add some space between the boxes
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
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
    final appatiteRepo = AppatiteRepository();
    final patient = session.patient;
    final user = session.user;

    // Check the patient's status
    var status = appatiteRepo.getPatientState(user!, patient!);
    var statusEnum = appatiteRepo.stringToPatientStatus(status);


    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContent(statusEnum),
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