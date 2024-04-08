import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/treatment.dart' as patient_models;


class HistoricoTratamentos extends StatefulWidget {
  final Patient patient;

  const HistoricoTratamentos({Key? key, required this.patient}) : super(key: key);

  @override
  _HistoricoTratamentosState createState() => _HistoricoTratamentosState();
}

class _HistoricoTratamentosState extends State<HistoricoTratamentos> {
  List<patient_models.Treatment>? treatments;

  @override
  void initState() {
    super.initState();
    treatments = widget.patient.getTreatmentList();
  }

  @override
  Widget build(BuildContext context) {
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
