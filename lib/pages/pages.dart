import 'package:flutter/material.dart';
import 'package:tfc_flutter/pages/TratamentosParaHoje.dart';
import 'package:tfc_flutter/pages/PesquisarUtente.dart';

final pages = [
  (title: 'Tratamentos Para Hoje', icon: Icons.list, widget: TratamentosParaHoje()),
  (title: 'Pesquisar Utentes', icon: Icons.search, widget: PesquisarUtente()),
];