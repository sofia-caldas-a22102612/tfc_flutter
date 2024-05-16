import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/model/test.dart' as TestModel;
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

import '../../../model/user.dart';

class NovoRastreio extends StatefulWidget {
  const NovoRastreio({Key? key}) : super(key: key);

  @override
  _NovoRastreioState createState() => _NovoRastreioState();
}

class _NovoRastreioState extends State<NovoRastreio> {
  bool? diagnosis;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation; // Change type to int
  final List<int> testLocationOptions = [1, 2]; // Define options
  Color positiveButtonColor = Colors.transparent; // Initial color of positive button
  Color negativeButtonColor = Colors.transparent; // Initial color of negative button

  Future<void> _selectDate(BuildContext context, bool isTestDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isTestDate) {
          testDate = pickedDate;
          diagnosis = false;
        } else {
          resultDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    Patient? patient = session.patient;
    User? user = session.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Rastreio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Teste Rastreio',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10),
                      Text(
                        'Test Date: ${testDate != null ? testDate!.toString().split(' ')[0] : "Select a date"}',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10),
                      Text(
                        'Result Date: ${resultDate != null ? resultDate!.toString().split(' ')[0] : "Select a date"}',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                        positiveButtonColor = Colors.green; // Change color to green when selected
                        negativeButtonColor = Colors.transparent; // Reset color of negative button
                      });
                    },
                    child: Text('Positive'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: positiveButtonColor, // Apply color based on state
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = false;
                        negativeButtonColor = Colors.red; // Change color to red when selected
                        positiveButtonColor = Colors.transparent; // Reset color of positive button
                      });
                    },
                    child: Text('Negative'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: negativeButtonColor, // Apply color based on state
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DropdownButton<int>(
                value: testLocation,
                hint: Text('Test Location'),
                onChanged: (int? newValue) {
                  setState(() {
                    testLocation = newValue;
                  });
                },
                items: testLocationOptions.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('Option $value'),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (diagnosis == true) {
                    TestModel.Test newRastreio = createRastreio(patient!);
                    patient.addRastreio(newRastreio);
                    patient.addTest(newRastreio);
                    appatiteRepo.insertNewTest(user!, newRastreio);
                    patient.updatePatientState(PatientStatus.POSITIVE_SCREENING_DIAGNOSIS);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginaEditarDiagnostico(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TestModel.Test createRastreio(Patient patient) {
    return TestModel.Test(
      diagnosis: diagnosis,
      testDate: testDate,
      resultDate: resultDate,
      result: result,
      testLocation: testLocation,
      patient: patient,
    );
  }
}
