import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/pages/pages.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import '../patientPages/mainPatientPage.dart';

class PesquisarUtente extends StatelessWidget {
  const PesquisarUtente({Key? key});

  @override
  Widget build(BuildContext context) {
    var zeusRepository = context.read<ZeusRepository>();

    // Declare a TextEditingController to handle user input
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController, // Connect the TextEditingController to the TextFormField
              decoration: InputDecoration(
                labelText: 'Pesquisar Utente',
                prefixIcon: Icon(Icons.search), // Add search icon
                suffixIcon: ElevatedButton(
                  onPressed: () {
                    // Show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Return the dialog widget
                        return AlertDialog(
                          title: Text('Matching Patients'),
                          content: Container(
                            width: double.maxFinite,
                            height: 300, // Set a fixed height for the list
                            child: FutureBuilder(
                              future: zeusRepository.searchPatientsTest(searchController.text), // Pass user input to searchPatients
                              builder: (BuildContext context, AsyncSnapshot<List<Patient>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Show a loading indicator while fetching data
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}'); // Show an error message if data fetching fails
                                } else {
                                  // Data has been successfully fetched
                                  // Check if there are matching results
                                  if (snapshot.data == null) {
                                    return Center(
                                      child: Text(
                                        'Sem Resultados',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }

                                  if (snapshot.data!.isEmpty) {
                                    // No matching results, display message
                                    return Center(
                                      child: Text(
                                        'Não existem utentes com esses dados',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  } else {
                                    // Display the matching patients
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length, // Use the length of the fetched data
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(snapshot.data![index].getName()), // Replace with patient name
                                          onTap: () {
                                            // Navigate to the Patient page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MainPatientPage(patient: snapshot.data![index]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Search'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
