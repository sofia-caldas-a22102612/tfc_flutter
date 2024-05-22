import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/patientPages/states/paginaTratamento.dart';


class PaginaTesteDiagnosticoPositivo extends StatelessWidget {
  const PaginaTesteDiagnosticoPositivo({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste Diagnóstico Positivo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Diagnóstico guardado',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaTesteDiagnosticoPositivo(),
                  ),
                );
              },
              child: Text('Editar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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