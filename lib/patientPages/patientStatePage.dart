import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
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
    return FutureBuilder<PatientStatus?>(
      future: _getPatientState(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final patientState = snapshot.data;
          print('Patient State: $patientState');  // Debug print
          switch (patientState) {
            case PatientStatus.NED:
              return PaginaNED();
            case PatientStatus.POSITIVE_SCREENING_DIAGNOSIS:
            case PatientStatus.POSITIVE_DIAGNOSIS:
              return PaginaTesteDiagnosticoPositivo();
            case PatientStatus.TREATMENT:
            case PatientStatus.POST_TREATMENT_ANALYSIS:
              return PaginaTratamento();
            case PatientStatus.FINISHED:
              return PaginaNED();
            default:
              return Center(child: Text('Invalid patient status'));
          }
        }
      },
    );
  }

  Future<PatientStatus?> _getPatientState(BuildContext context) async {
    final session = context.watch<Session>();
    var appatiteRepository = context.read<AppatiteRepository>();
    final patient = session.patient;
    final user = session.user;

    if (user == null || patient == null) {
      return null;
    }
    return appatiteRepository.getPatientState(user, patient);
  }
}
