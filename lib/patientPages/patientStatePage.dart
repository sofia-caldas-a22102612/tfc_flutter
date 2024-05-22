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
  Future<String?>? _patientStateFuture;

  @override
  void initState() {
    super.initState();
    _fetchPatientState(); // Call the function to fetch patient state
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
              return Center(child: Text('Invalid patient status: $patientState'));
          }
        }
      },
    );
  }

  void _fetchPatientState() {
    final session = context.read<Session>();
    final patient = session.patient;
    final user = session.user;

    if (user == null || patient == null) {
      Exception;
     // todo throw nullpoint exception
    }

    final repository = Provider.of<AppatiteRepository>(context, listen: false);
    setState(() {
      _patientStateFuture = repository.getPatientState(user!, patient!); // Fetch patient state
    });
  }
}

class AuthenticationException implements Exception {}
