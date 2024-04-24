import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';

import '../model/session.dart';
import '../repository/appatite_repository.dart';

class PatientStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPatientStatePage(context);
  }

  Widget _buildPatientStatePage(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getPatientState(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final patientState = snapshot.data;
          switch (patientState) {
            case 'NED':
              return PaginaNED();
            case 'POSITIVE_SCREENING_DIAGNOSIS':
              return PaginaTesteDiagnosticoPositivo();
            case 'POSITIVE_DIAGNOSIS':
              return PaginaTesteDiagnosticoPositivo();
            case 'TREATMENT':
              return PaginaTratamento();
            case 'POST_TREATMENT_ANALYSIS':
              return PaginaTratamento();
            case 'FINISHED':
              return PaginaNED();
            default:
              throw Exception('Invalid patient status');
          }
        }
      },
    );
  }

  Future<String?> _getPatientState(BuildContext context) async {
    final session = context.watch<Session>();
    var appatiteRepository = context.read<AppatiteRepository>();
    final patient = session.patient;
    final user = session.user;

    if (user == null || patient == null) {
      return 'NED';
    }
    return appatiteRepository.getPatientState(user, patient);
  }
}
