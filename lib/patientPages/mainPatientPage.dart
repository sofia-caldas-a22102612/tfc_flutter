import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/pages/main.page.dart';
import 'package:tfc_flutter/patientPages/patientPages.dart';

class MainPatientPage extends StatefulWidget {
  @override
  State<MainPatientPage> createState() => _MainPatientPageState();
}


class _MainPatientPageState extends State<MainPatientPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0; // Reset _selectedIndex to its initial value
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    return Scaffold(
      appBar: AppBar(
        title: Text(session.patient!.getName()),
      ),
      body: pages[_selectedIndex].widget,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (pages[index].title == 'Voltar') {
            // need to do this, to clear any previous push stack that may exist
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainPage()), (_) => false
            );
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        destinations: pages.map((page) => NavigationDestination(icon: Icon(page.icon), label: page.title)).toList(),
      ),
    );
  }
}

