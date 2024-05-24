import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/patientPages/states/testPages/diagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class PaginaTratamento extends StatefulWidget {
  const PaginaTratamento({Key? key}) : super(key: key);

  @override
  _PaginaTratamentoState createState() => _PaginaTratamentoState();
}

class _PaginaTratamentoState extends State<PaginaTratamento> {
  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    final patient = session.patient;
    final user = session.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Tratamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome do Paciente:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(patient!.getName()),
            SizedBox(height: 20),
            Text(
              'Data de nascimento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(patient.getBirthdate().toString()),
            SizedBox(height: 20),
            Text(
              'Data de Início do Tratamento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(patient.getCurrentTreatment().startDate.toString()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaEditarDiagnostico(),
                  ),
                );
              },
              child: Text('Editar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main patient page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPatientPage(),
                  ),
                );
              },
              child: Text('Começar Tratamento'),
            ),
          ],
        ),
      ),
    );
  }
}
