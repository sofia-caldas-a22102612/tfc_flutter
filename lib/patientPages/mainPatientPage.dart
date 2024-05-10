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
    final session = context.watch<Session>();
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedIndex].title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.person),
            itemBuilder: (context) => [PopupMenuItem(value: 0, child: Text('Sair'))],
            onSelected: (index) => session.user = null,
          )
        ],
      ),
      body: pages[_selectedIndex].widget,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: pages.map((page) => NavigationDestination(icon: Icon(page.icon), label: page.title)).toList(),
      ),
    );
  }
}
