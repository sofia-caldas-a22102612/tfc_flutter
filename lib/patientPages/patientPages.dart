import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/PatientDetailPage.dart';
import 'package:tfc_flutter/patientPages/historicoTratamentos.dart';
import 'package:tfc_flutter/patientPages/patientStatePage.dart';
import 'package:tfc_flutter/patientPages/states/paginaPosTratamento.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/states/paginaTratamento.dart';
import '../model/patient.dart'; // Import your Patient model

List<Map<String, dynamic>> PatientPages(Patient patient) {
  return [
    {
      'title': 'Estado Corrente',
      'icon': Icons.check_circle,
      'widget': PatientStatePage(patient: patient),
    },
    {
      'title': 'Informação do Utente',
      'icon': Icons.plus_one,
      'widget': PatientDetailPage(patient: patient),
    },
    {
      'title': 'Tratamento',
      'icon': Icons.circle,
      'widget': HistoricoTratamentos(patient: patient),
    },
    {
      'title': 'Teste De Diagnóstico Positivo',
      'icon': Icons.mark_as_unread,
      'widget': PaginaTesteDiagnosticoPositivo(patient: patient),
    },
  ];
}

