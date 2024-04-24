import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/patientPages.dart';

class MainPatientPage extends StatefulWidget {

  @override
  State<MainPatientPage> createState() => _MainPatientPageState();
}

class _MainPatientPageState extends State<MainPatientPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //todo obter sessao a partir do provider e a seguir fazer sessao.patient = this.patient
    final session = context.watch<Session>();
    final patient = session.patient;
    return Scaffold(
        appBar: AppBar(title: Text(pages[_selectedIndex].title),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.person),
              itemBuilder: (context) => [PopupMenuItem(value: 0, child: Text('Sair'))],
              onSelected: (index) => session.user = null,
            )
          ],),
        body: pages[_selectedIndex].widget,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: pages.map((page) => NavigationDestination(icon: Icon(page.icon), label: page.title)).toList(),
        )
    );
  }
}

