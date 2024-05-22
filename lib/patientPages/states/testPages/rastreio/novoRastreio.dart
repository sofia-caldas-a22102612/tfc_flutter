import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tfc_flutter/model/patient.dart';
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
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
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
        title: Text('Novo Rastreio (${session.patient?.getName()})'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _fbKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teste Rastreio',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 60, // Adjust the height as needed
                  child: FormBuilderDateTimePicker(
                    name: 'testDate',
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      labelText: 'Test Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onChanged: (DateTime? value) {
                      // Handle changes if needed
                    },
                    //todo add validator
                  ),
                ),

                SizedBox(height: 40), // Add spacing here

                SizedBox(
                  height: 60, // Adjust the height as needed
                  child: FormBuilderDateTimePicker(
                    name: 'resultDate',
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      labelText: 'Result Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onChanged: (DateTime? value) {
                      // Handle changes if needed
                    },
                    //todo add validator
                  ),
                ),

                SizedBox(height: 40), // Add spacing here

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

                SizedBox(height: 40), // Add spacing here

                FormBuilderDropdown<int>(
                  name: 'testLocation',
                  decoration: InputDecoration(labelText: 'Test Location'),
                  items: [1, 2]
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text('Option $value'),
                  ))
                      .toList(),
                  onChanged: (int? value) {
                    // Handle changes if needed
                  },
                  //todo add validator
                ),

                SizedBox(height: 50), // Add spacing here

                Center( // Wrap the button with Center widget
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_fbKey.currentState!.saveAndValidate()) {
                        final values = _fbKey.currentState!.value;
                        final positiveDiagnosis = values['result'] == true;
                        final testDate = values['testDate'];
                        final resultDate = values['resultDate'];
                        final testLocation = values['testLocation'];

                        final newRastreio = TestModel.Test(
                          diagnosis: positiveDiagnosis,
                          testDate: testDate,
                          resultDate: resultDate,
                          result: result,
                          testLocation: testLocation,
                          patient: patient!,
                        );


                        final patientStatus = positiveDiagnosis ?
                          PatientStatus.POSITIVE_SCREENING_DIAGNOSIS
                        :
                          PatientStatus.NED;


                        await appatiteRepo.insertNewTest(user!, newRastreio);
                        await appatiteRepo.changeState(user, patient, patientStatus);

                        patient.addRastreio(newRastreio);
                        patient.addTest(newRastreio);

                        //todo remove this in the future
                        patient.updatePatientState(patientStatus);

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
