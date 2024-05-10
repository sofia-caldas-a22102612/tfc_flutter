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
    title: 'Histórico',
    icon: Icons.list,
    widget: HistoricoMain(),
),
    (
    title: 'Dados Utente',
    icon: Icons.person,
    widget: PatientDetailPage(),
    ),
(
    title: 'Voltar',
    icon: Icons.settings_backup_restore,
    widget: PaginaTesteDiagnosticoPositivo(),
),
];



