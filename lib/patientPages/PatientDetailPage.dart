import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';

class PatientDetailPage extends StatefulWidget {
  final Patient patient; // Add a patient parameter

  PatientDetailPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDetailItem('Name', widget.patient.getName()), // Accessing patient using widget.patient
          _buildDetailItem('ID', widget.patient.getId()),
          _buildDetailItem('CC', widget.patient.getCC()),
          _buildDetailItem('Gender', widget.patient.getBirthdate().toString()),
          _buildDetailItem('Age', widget.patient.getAge().toString()),
          _buildDetailItem('Real ID', widget.patient.getRealId()?.toString() ?? 'N/A'),
          _buildDetailItem('Document Type', widget.patient.getDocumentType()?.toString() ?? 'N/A'),
          _buildDetailItem('Last Program Name', widget.patient.getLastProgramName() ?? 'N/A'),
          _buildDetailItem('Last Program Date', widget.patient.getLastProgramDate()?.toString() ?? 'N/A'),
          _buildDetailItem('User ID', widget.patient.getUserId().toString()),
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
