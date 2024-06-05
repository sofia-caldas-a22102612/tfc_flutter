import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/patientPages/states/testPages/diagnosticsState/paginaEditarDiagnostico.dart';

class NovoDiagnostico extends StatefulWidget {
  const NovoDiagnostico({Key? key}) : super(key: key);

  @override
  _NovoDiagnosticoState createState() => _NovoDiagnosticoState();
}

class _NovoDiagnosticoState extends State<NovoDiagnostico> {
  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    return Scaffold(
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
                    builder: (context) => PaginaEditarDiagnostico(),
                  ),
                );
              },
              child: Text('Editar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                patient!.updatePatientState(PatientStatus.TREATMENT, null);
                // Change the PatientState to indicate treatment has started
                patient.updatePatientState(PatientStatus.TREATMENT, null);
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
