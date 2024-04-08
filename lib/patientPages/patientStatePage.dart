import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/patientPages/states/paginaFinished.dart';
import 'package:tfc_flutter/patientPages/states/NED/paginaNED.dart';
import 'package:tfc_flutter/patientPages/states/paginaPosTratamento.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/states/paginaTratamento.dart';

class PatientStatePage extends StatefulWidget {
  final Patient patient;

  PatientStatePage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientStatePage> createState() => _PatientStatePageState();
}

class _PatientStatePageState extends State<PatientStatePage> {
  @override
  Widget build(BuildContext context) {
    Widget selectedPage;

    switch (widget.patient.getPatientState()) {
      case PatientStatus.NED:
        selectedPage = PaginaNED(patient: widget.patient);
        break;
      case PatientStatus.POSITIVE_DIAGNOSIS:
        selectedPage = PaginaEditarDiagnostico(patient: widget.patient);
        break;
      case PatientStatus.TREATMENT:
        selectedPage = PaginaTratamento(patient: widget.patient);
        break;
      case PatientStatus.FINISHED:
        selectedPage = PaginaFinished(patient: widget.patient);
        break;
      case PatientStatus.POST_TREATMENT_ANALYSIS:
        selectedPage = PaginaPosTratamento(patient: widget.patient);
        break;
      case PatientStatus.POSITIVE_SCREENING_DIAGNOSIS:
      // TODO: Handle this case.
        selectedPage = Placeholder(); // Placeholder until handling is implemented
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.patient.getName()}, ${widget.patient.getAge()}'),
          ],
        ),
      ),
      body: selectedPage,
      // No need for bottomNavigationBar
    );
  }
}
