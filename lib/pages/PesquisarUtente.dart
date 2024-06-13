import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/gender_type.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';
import '../model/session.dart';
import '../patientPages/mainPatientPage.dart';

class PesquisarUtente extends StatefulWidget {
  PesquisarUtente({Key? key});

  @override
  State<PesquisarUtente> createState() => _PesquisarUtenteState();
}

class _PesquisarUtenteState extends State<PesquisarUtente> {
  String? _searchText;

  @override
  Widget build(BuildContext context) {
    var zeusRepository = context.read<ZeusRepository>();
    final session = context.watch<Session>();
    final user = session.user;
    // Declare a TextEditingController to handle user input
    TextEditingController searchController = TextEditingController();
    // if (_searchText != null) {
    //   searchController.text = _searchText!;
    // }

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
                    setState(() {
                      _searchText = searchController.text;
                    });

                    // _showDialog(context, zeusRepository, user!, searchController.text, session);
                  },
                  child: Text('Search'),
                ),
              ),
            ),
          ),
          _searchText == null
              ? Container()
              : FutureBuilder(
                  future: zeusRepository.searchPatients(user!, _searchText!),
                  builder: (_, snapshot) {

                    // dismiss the keyboard
                    FocusScope.of(context).unfocus();

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Show an error message if data fetching fails
                    } else {

                      _searchText = null;

                      final patients = snapshot.data!;
                      patients.sort((p1, p2) => p1.getName().compareTo(p2.getName()));

                      if (patients.isEmpty) {
                        return Center(
                          child: Text(
                            'Sem Resultados',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, index) => ListTile(
                            leading: patients[index].getGender() == GenderType.male
                                ? Icon(Icons.man)
                                : patients[index].getGender() == GenderType.female
                                    ? Icon(Icons.woman)
                                    : null,
                            title: Text(patients[index].getName()),
                            trailing: Text(DateFormat('yyyy-MM-dd').format(patients[index].getBirthdate())),
                            onTap: () {
                              session.patient = patients[index];
                              // Navigate to the Patient page
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => MainPatientPage()),
                                (_) => false,
                              );
                            },
                          ),
                          separatorBuilder: (_, index) => Divider(color: Colors.grey, thickness: 0.5),
                          itemCount: patients.length,
                        ),
                      );
                    }
                  }),
        ],
      ),
    );
  }


  // no longer used
  // void _showDialog(BuildContext context, ZeusRepository zeusRepository, User user, String text, Session session) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // Return the dialog widget
  //       return AlertDialog(
  //         title: Text('Matching Patients'),
  //         content: Container(
  //           width: double.maxFinite,
  //           height: 300, // Set a fixed height for the list
  //           child: FutureBuilder(
  //             future: zeusRepository.searchPatients(user, text), // Pass user input to searchPatients
  //             builder: (BuildContext context, AsyncSnapshot<List<Patient>> snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return CircularProgressIndicator(); // Show a loading indicator while fetching data
  //               } else if (snapshot.hasError) {
  //                 return Text('Error: ${snapshot.error}'); // Show an error message if data fetching fails
  //               } else {
  //                 // Data has been successfully fetched
  //                 // Check if there are matching results
  //                 if (snapshot.data == null) {
  //                   return Center(
  //                     child: Text(
  //                       'Sem Resultados',
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   );
  //                 }
  //
  //                 if (snapshot.data!.isEmpty) {
  //                   // No matching results, display message
  //                   return Center(
  //                     child: Text(
  //                       'Não existem utentes com esses dados',
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   );
  //                 } else {
  //                   // Display the matching patients
  //                   return ListView.builder(
  //                     itemCount: snapshot.data!.length, // Use the length of the fetched data
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return ListTile(
  //                         title: Text(snapshot.data![index].getName()), // Replace with patient name
  //                         onTap: () {
  //                           session.patient = snapshot.data![index];
  //                           // Navigate to the Patient page
  //                           Navigator.of(context).pushAndRemoveUntil(
  //                             MaterialPageRoute(builder: (context) => MainPatientPage()),
  //                             (_) => false,
  //                           );
  //                         },
  //                       );
  //                     },
  //                   );
  //                 }
  //               }
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               // Close the dialog
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
