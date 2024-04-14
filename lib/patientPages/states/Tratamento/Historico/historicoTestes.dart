import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart' as patient_models;

import '../../../../model/session.dart';


class HistoricoTestes extends StatefulWidget {


  const HistoricoTestes({super.key});

  @override
  _HistoricoTestesState createState() => _HistoricoTestesState();
}

class _HistoricoTestesState extends State<HistoricoTestes> {
  List<patient_models.Treatment>? treatments;


  @override
  Widget build(BuildContext context) {

    final session = context.watch<Session>();
    Patient? patient = session.patient;

    if (treatments == null || treatments!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Patient Treatment History'),
        ),
        body: Center(
          child: Text('Não há Histórico de Tratamentos'),
        ),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Patient Treatment History'),
        ),
        body: ListView.builder(
          itemCount: treatments!.length,
          itemBuilder: (context, index) {
            final treatment = treatments![index];
            return ListTile(
              title: Text('Treatment ID: ${treatment.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Date: ${treatment.startDate ?? 'N/A'}'),
                  Text('End Date: ${treatment.realEndDate ?? 'N/A'}'),
                  Text('Medication Name: ${treatment.nameMedication ?? 'N/A'}'),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
