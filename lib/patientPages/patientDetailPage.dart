import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';

import '../model/session.dart';

class PatientDetailPage extends StatefulWidget {

  PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    Patient? patient = session.patient;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDetailItem('Name', patient!.getName()), // Accessing patient using widget.patient
          _buildDetailItem('ID', patient.getIdZeus().toString()),
          _buildDetailItem('CC', patient.getCC()),
          _buildDetailItem('Gender', patient.getBirthdate().toString()),
          _buildDetailItem('Age', patient.getAge().toString()),
          _buildDetailItem('Real ID', patient.getRealId()?.toString() ?? 'N/A'),
          _buildDetailItem('Document Type', patient.getDocumentType()?.toString() ?? 'N/A'),
          _buildDetailItem('Last Program Name', patient.getLastProgramName() ?? 'N/A'),
          _buildDetailItem('Last Program Date', patient.getLastProgramDate()?.toString() ?? 'N/A'),
          _buildDetailItem('User ID', patient.getUserId().toString()),
        ].expand((widget) => [widget, SizedBox(height: 8), Divider(), SizedBox(height: 8)]).toList(), // Add SizedBox for spacing
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Adjust vertical padding
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
