import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/paginaTratamento.dart';
import '../repository/appatite_repository.dart';

class PatientStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPatientStatePage(context);
  }

  Widget _buildPatientStatePage(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getPatientState(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data ?? SizedBox();
        }
      },
    );
  }

  Future<Widget> _getPatientState(BuildContext context) async {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    final patient = session.patient;
    final user = session.user;

    if (user == null || patient == null) {
      return SizedBox();
    }

    switch (appatiteRepo.getPatientState(user, patient)) {
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
}


//todo isto é uma boa prática?