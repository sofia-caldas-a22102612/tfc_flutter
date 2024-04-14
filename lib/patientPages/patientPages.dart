import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/PatientDetailPage.dart';
import 'package:tfc_flutter/patientPages/patientStatePage.dart';
import 'package:tfc_flutter/patientPages/states/Tratamento/Historico/historicoTratamentos.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';


final pages = [
(
    title: 'Estado Corrente',
    icon: Icons.check_circle,
    widget: PatientStatePage(),
),
(
    title: 'Informação do Utente',
    icon: Icons.plus_one,
    widget: PatientDetailPage(),
),
(
    title: 'Tratamento',
    icon: Icons.circle,
    widget: HistoricoTratamentos(),
),
(
    title: 'Voltar ao Menu Principal',
    icon: Icons.mark_as_unread,
    widget: PaginaTesteDiagnosticoPositivo(),
),
];



