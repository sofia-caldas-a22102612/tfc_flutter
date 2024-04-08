import 'package:flutter/material.dart';
import 'package:tfc_flutter/patientPages/patientPages.dart';
import '../model/patient.dart';

class MainPatientPage extends StatefulWidget {
  final Patient patient; // Add a patient parameter

  MainPatientPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<MainPatientPage> createState() => _MainPatientPageState();
}

class _MainPatientPageState extends State<MainPatientPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _selectedIndex,
        children: PatientPages(widget.patient).map((page) {
          if (page['title'] == 'Main Patient Page') {
            // Return MainPatientPage widget with the provided patient
            return MainPatientPage(patient: widget.patient);
          } else {
            return page['widget'] as Widget;
          }
        }).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: PatientPages(widget.patient).map((page) => NavigationDestination(
          icon: Icon(page['icon'] as IconData),
          label: page['title'] as String,
        )).toList(),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
        );
      }).toList(),
    );
  }
}

