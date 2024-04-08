import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/states/paginaPosTratamento.dart';

class PaginaTratamento extends StatelessWidget {
  final Patient patient;

  const PaginaTratamento({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Em Tratamento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(patient.getName()),
              subtitle: Text('${patient.getAge()} anos'),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                // Show popup when button is clicked
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmar Toma'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // TextField for notes
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Notas',
                              hintText: 'Adicione notas opcionais',
                            ),
                          ),
                          SizedBox(height: 20),
                          // Button to confirm
                          TextButton(
                            onPressed: () {
                              // Add action for dark green button
                              Navigator.pop(context); // Close the popup
                            },
                            child: Text(
                              'Confirmar Toma',
                              style: TextStyle(
                                color: Colors.white, // White color
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[900], // Dark green color
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the popup
                          },
                          child: Text(
                            'Fechar',
                            style: TextStyle(
                              color: Colors.white, // White color
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red[900], // Dark green color
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Registar Toma',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaPosTratamento(patient: patient),
                  ),
                );
              },
              child: Text('Acabar Tratamento'),
            ),
          ],
        ),
      ),
    );
  }
}
