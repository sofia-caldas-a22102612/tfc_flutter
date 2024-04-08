import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/PatientDetailPage.dart';
import 'package:tfc_flutter/patientPages/paginaPosTratamento.dart';
import 'package:tfc_flutter/patientPages/paginaTesteDIagnosticoPositivo.dart';
import 'package:tfc_flutter/patientPages/paginaTratamento.dart';
import '../model/patient.dart'; // Import your Patient model

List<Map<String, dynamic>> PatientPages(Patient patient) {
  return [
    {
      'title': 'Informação do Paciente',
      'icon': Icons.check_circle,
      'widget': PaginaSemEvidenciaDeDoenca(patient: patient),
    },
    {
      'title': 'Estado Corrente',
      'icon': Icons.plus_one,
      'widget': PaginaTratamento(patient: patient),
    },
    {
      'title': 'Tratamento',
      'icon': Icons.circle,
      'widget': PaginaPosTratamento(patient: patient),
    },
    {
      'title': 'Teste De Diagnóstico Positivo',
      'icon': Icons.mark_as_unread,
      'widget': PaginaTesteDiagnosticoPositivo(patient: patient),
    },
  ];
}

