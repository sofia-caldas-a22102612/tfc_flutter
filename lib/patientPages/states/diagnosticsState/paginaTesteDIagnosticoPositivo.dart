import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/patientPages/states/paginaTratamento.dart';


class PaginaTesteDiagnosticoPositivo extends StatelessWidget {
  final Patient patient;

  const PaginaTesteDiagnosticoPositivo({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => PaginaEditarDiagnostico(patient: patient),
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
                    builder: (context) => PaginaTratamento(patient: patient),
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
