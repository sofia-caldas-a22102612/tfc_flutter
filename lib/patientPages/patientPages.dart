import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/PatientDetailPage.dart';
import 'package:tfc_flutter/patientPages/patientStatePage.dart';
import 'package:tfc_flutter/patientPages/states/Historico/historicoMain.dart';
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
    title: 'Histórico',
    icon: Icons.circle,
    widget: HistoricoMain(),
),
(
    title: 'Voltar ao Menu Principal',
    icon: Icons.mark_as_unread,
    widget: PaginaTesteDiagnosticoPositivo(),
),
];



