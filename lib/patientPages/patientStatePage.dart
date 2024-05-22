import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';
import '../model/session.dart';
import '../repository/appatite_repository.dart';

class PatientStatePage extends StatefulWidget {
  @override
  _PatientStatePageState createState() => _PatientStatePageState();
}

class _PatientStatePageState extends State<PatientStatePage> {
  Future<String?>? _patientStateFuture;

  @override
  void initState() {
    super.initState();
    _patientStateFuture = _getPatientState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _patientStateFuture,
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
              return Center(child: Text('Invalid patient status'));
          }
        }
      },
    );
  }

  Future<String?> _getPatientState() async {
    final session = context.read<Session>();
    final patient = session.patient;
    final user = session.user;

    if (user == null || patient == null) {
      return 'NED';
    }

    final repository = Provider.of<AppatiteRepository>(context, listen: false);
    return repository.getPatientState(user, patient);
  }
}
