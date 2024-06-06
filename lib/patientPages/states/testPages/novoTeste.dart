import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class NovoTeste extends StatefulWidget {
  const NovoTeste({Key? key}) : super(key: key);

  @override
  _NovoTesteState createState() => _NovoTesteState();
}

class _NovoTesteState extends State<NovoTeste> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedTestDate;
  DateTime? selectedResultDate;
  bool? result;
  int? testLocation;
  int? testType;
  Color positiveButtonColor = Colors.transparent;
  Color negativeButtonColor = Colors.transparent;
  Future<bool>? _submitFuture;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final appatiteRepo = AppatiteRepository();
    final patient = session.patient;
    final user = session.user;

    // Ensure patient and user are not null before accessing their properties
    if (patient == null || user == null) {
      return Scaffold(
        body: Center(
          child: Text('No patient or user information available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Teste (${patient.getName()})'),
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
                    labelText: 'Data do Teste',
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
                      return 'Selecione data do teste';
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
                    labelText: 'Data do Resultado',
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
                      return 'Selecione data do resultado';
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
                  'Resultado',
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
                      child: Text('Positivo'),
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
                      child: Text('Negativo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: negativeButtonColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<int>(
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Instalações Adp'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Hospital'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Unidade Móvel'),
                    ),
                  ],
                  decoration: InputDecoration(labelText: 'Local do Teste'),
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione local do teste';
                    }
                    return null;
                  },
                  onChanged: (int? value) {
                    setState(() {
                      testLocation = value;
                    });
                  },
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<int>(
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Rastreio'),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Diagnostico'),
                    ),
                  ],
                  decoration: InputDecoration(labelText: 'Tipo de Teste'),
                  onChanged: (int? value) {
                    setState(() {
                      testType = value;
                    });
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selecione Resultado')),
                          );
                          return;
                        }
                        setState(() {
                          _submitFuture = appatiteRepo.insertNewTest(
                            user,
                            result: result,
                            resultDate: selectedResultDate,
                            testLocation: testLocation!,
                            testDate: selectedTestDate,
                            type: testType ?? 0,
                            patient: patient,
                          );
                        });
                      }
                    },
                    child: Text('Guardar'),
                  ),
                ),
                SizedBox(height: 20),
                _submitFuture == null
                    ? Container()
                    : FutureBuilder<bool>(
                  future: _submitFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      if (snapshot.error is NotFoundException) {
                        return Text('Resource not found');
                      } else {
                        return Text('Error: ${snapshot.error}');
                      }
                    } else if (snapshot.hasData && snapshot.data == true) {
                      Future.microtask(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPatientPage(),
                          ),
                        );
                      });
                      return Text('Test saved successfully');
                    } else {
                      return Text('Failed to save test');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
