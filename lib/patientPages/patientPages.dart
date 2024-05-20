import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/PatientDetailPage.dart';
import 'package:tfc_flutter/patientPages/pageDetail.dart';
import 'package:tfc_flutter/patientPages/patientStatePage.dart';
import 'package:tfc_flutter/patientPages/states/Historico/historicoMain.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaTesteDIagnosticoPositivo.dart';

final List<PageDetail> pages = [
    PageDetail(
        title: 'Estado Corrente',
        icon: Icons.check_circle,
        widget: PatientStatePage(),
    ),
    PageDetail(
        title: 'Histórico',
        icon: Icons.list,
        widget: HistoricoMain(),
    ),
    PageDetail(
        title: 'Dados Utente',
        icon: Icons.person,
        widget: PatientDetailPage(),
    ),
    PageDetail(
        title: 'Voltar',
        icon: Icons.settings_backup_restore,
        widget: PaginaTesteDiagnosticoPositivo(),
    ),
];
