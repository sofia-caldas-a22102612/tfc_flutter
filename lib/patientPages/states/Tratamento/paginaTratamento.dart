import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class PaginaTratamento extends StatefulWidget {
  const PaginaTratamento({Key? key}) : super(key: key);

  @override
  _PaginaTratamentoState createState() => _PaginaTratamentoState();
}

class _PaginaTratamentoState extends State<PaginaTratamento> {
  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final patient = session.patient;
    final user = session.user;

    if (patient == null || user == null) {
      return Scaffold(
        body: Center(
          child: Text('No patient or user information available'),
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder<Treatment?>(
        future: context.read<AppatiteRepository>().getCurrentTreatment(user, patient.getIdZeus()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No current treatment found'));
          } else {
            final currentTreatment = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalhes do Tratamento',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 40),
                  Text('Data de Início: ${currentTreatment.startDate}'),
                  SizedBox(height: 20),
                  Text('Medicamento: ${currentTreatment.nameMedication ?? 'Não especificado'}'),
                  SizedBox(height: 20),
                  Text('Duração: ${currentTreatment.treatmentDuration ?? 'Indefinido'} semanas'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
