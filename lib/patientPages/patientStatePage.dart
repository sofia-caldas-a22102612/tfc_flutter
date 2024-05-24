import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';
import 'package:tfc_flutter/patientPages/states/testPages/diagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import '../model/session.dart';
import '../repository/appatite_repository.dart';

class PatientStatePage extends StatefulWidget {
  @override
  _PatientStatePageState createState() => _PatientStatePageState();
}

class _PatientStatePageState extends State<PatientStatePage> {

  @override
  Widget build(BuildContext context) {

    final repository = context.read<AppatiteRepository>();
    final session = context.read<Session>();
    final patient = session.patient;
    final user = session.user;

    return FutureBuilder<String?>(
      future: repository.getPatientState(user!, patient!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final patientState = snapshot.data;
          print('Patient State: $patientState'); // Debug print
          switch (patientState) {
            case 'NED':
              return PaginaNED();
            case 'POSITIVE_SCREENING_DIAGNOSIS':
            case 'POSITIVE_DIAGNOSIS':
              return PaginaTesteDiagnosticoPositivo();
            case 'TREATMENT':
            case 'POST_TREATMENT_ANALYSIS':
              return PaginaTratamento();
            case 'FINISHED':
              return PaginaNED();
            default:
              return Center(child: Text('Invalid patient status: $patientState'));
          }
        }
      },
    );
  }
}

class AuthenticationException implements Exception {}
