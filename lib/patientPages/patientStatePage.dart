import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/patient_state.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';
import 'package:tfc_flutter/patientPages/states/testPages/diagnosticsState/paginaTesteDIagnostico.dart';
import '../model/session.dart';
import '../repository/appatite_repository.dart';

class PatientStatePage extends StatefulWidget {
  @override
  _PatientStatePageState createState() => _PatientStatePageState();
}

class _PatientStatePageState extends State<PatientStatePage> {
  @override
  void initState() {
    super.initState();
    // Add any initialization code here
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AppatiteRepository>();
    final session = context.read<Session>();
    final patient = session.patient;
    final user = session.user;

    return FutureBuilder<PatientState?>(
      future: repository.getPatientState(user!, patient!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No patient state found.'));
        } else {
          final patientState = snapshot.data!;
          print('Patient State: $patientState'); // Debug print

          Widget nextPage;
          switch (patientState.status) {
            case 'NED':
              patient.updatePatientState(PatientStatus.NED, patientState.statusDate);
              nextPage = PaginaNED();
              break;
            case 'NOT_IN_DATABASE':
              patient.updatePatientState(PatientStatus.NOT_IN_DATABASE, null);
              nextPage = PaginaNED();
              break;
            case 'POSITIVE_SCREENING':
              patient.updatePatientState(PatientStatus.POSITIVE_SCREENING, patientState.statusDate);
              nextPage = PaginaTesteDiagnostico();
              break;
            case 'POSITIVE_DIAGNOSIS':
              patient.updatePatientState(PatientStatus.POSITIVE_DIAGNOSIS, patientState.statusDate);
              nextPage = PaginaTesteDiagnostico();
              break;
            case 'TREATMENT':
              patient.updatePatientState(PatientStatus.TREATMENT, patientState.statusDate);
              nextPage = PaginaTratamento();
              break;
            case 'POST_TREATMENT_ANALYSIS':
              patient.updatePatientState(PatientStatus.POST_TREATMENT_ANALYSIS, patientState.statusDate);
              nextPage = PaginaTratamento();
              break;
            case 'FINISHED':
              patient.updatePatientState(PatientStatus.FINISHED, patientState.statusDate);
              nextPage = PaginaNED();
              break;
            default:
              nextPage = Center(child: Text('Invalid patient status: $patientState'));
              break;
          }

          return nextPage;
        }
      },
    );
  }
}

class AuthenticationException implements Exception {}
