import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart' as TestModel;
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class NovoRastreio extends StatefulWidget {
  const NovoRastreio({Key? key}) : super(key: key);

  @override
  _NovoRastreioState createState() => _NovoRastreioState();
}

class _NovoRastreioState extends State<NovoRastreio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedTestDate;
  DateTime? selectedResultDate;
  bool? result;
  Color positiveButtonColor = Colors.transparent;
  Color negativeButtonColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    final patient = session.patient;
    final user = session.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Rastreio (${patient?.getName() ?? ''})'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teste Rastreio',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Test Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null && pickedDate != selectedTestDate) {
                      setState(() {
                        selectedTestDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (selectedTestDate == null) {
                      return 'Please select a test date';
                    }
                    return null;
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedTestDate != null
                        ? "${selectedTestDate!.toLocal()}".split(' ')[0]
                        : '',
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Result Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null && pickedDate != selectedResultDate) {
                      setState(() {
                        selectedResultDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (selectedResultDate == null) {
                      return 'Please select a result date';
                    }
                    return null;
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedResultDate != null
                        ? "${selectedResultDate!.toLocal()}".split(' ')[0]
                        : '',
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Result',
                  style: TextStyle(fontSize: 19),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          result = true;
                          positiveButtonColor = Colors.green;
                          negativeButtonColor = Colors.transparent;
                        });
                      },
                      child: Text('Positive'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: positiveButtonColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          result = false;
                          negativeButtonColor = Colors.red;
                          positiveButtonColor = Colors.transparent;
                        });
                      },
                      child: Text('Negative'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: negativeButtonColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<int>(
                  items: [1, 2]
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text('Option $value'),
                  ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Test Location'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a test location';
                    }
                    return null;
                  }, onChanged: (int? value) {  },
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, proceed with saving
                        final testLocation = 1; // Replace with form value

                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a result')),
                          );
                          return;
                        }

                        final newRastreio = TestModel.Test(
                          diagnosis: result!,
                          testDate: selectedTestDate,
                          resultDate: selectedResultDate,
                          result: result,
                          testLocation: testLocation,
                          patient: patient!,
                        );

                        await appatiteRepo.insertNewTest(
                            user!, newRastreio, patient);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPatientPage(),
                          ),
                        );
                      }
                    },
                    child: Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
