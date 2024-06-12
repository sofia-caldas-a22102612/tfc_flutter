import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/patientPages/mainPatientPage.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class NovoTratamento extends StatefulWidget {
  const NovoTratamento({Key? key}) : super(key: key);

  @override
  _NovoTratamentoState createState() => _NovoTratamentoState();
}

class _NovoTratamentoState extends State<NovoTratamento> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedStartDate;
  DateTime? selectedExpectedEndDate;
  int? nameMedication;
  int? treatmentDuration;
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
        title: Text('Novo Tratamento (${patient.getName()})'),
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
                  'Detalhes do Tratamento',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Data de Início do Tratamento',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null && pickedDate != selectedStartDate) {
                      setState(() {
                        selectedStartDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (selectedStartDate == null) {
                      return 'Selecione data de início do tratamento';
                    }
                    return null;
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedStartDate != null
                        ? "${selectedStartDate!.toLocal()}".split(' ')[0]
                        : '',
                  ),
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<int>(
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Maviret'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Epclusa'),
                    ),
                  ],
                  decoration: InputDecoration(labelText: 'Nome do Medicamento'),
                  onChanged: (int? value) {
                    setState(() {
                      nameMedication = value;
                    });
                  },
                  validator: (value) {
                    if (nameMedication == null) {
                      return 'Selecione um medicamento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                DropdownButtonFormField<int>(
                  items: [
                    DropdownMenuItem(
                      value: 8,
                      child: Text('8 Semanas'),
                    ),
                    DropdownMenuItem(
                      value: 12,
                      child: Text('12 Semanas'),
                    ),
                    DropdownMenuItem(
                      value: 16,
                      child: Text('16 Semanas'),
                    ),
                  ],
                  decoration: InputDecoration(labelText: 'Duração do Tratamento'),
                  onChanged: (int? value) {
                    setState(() {
                      treatmentDuration = value;
                    });
                  },
                  validator: (value) {
                    if (treatmentDuration == null) {
                      return 'Selecione a duração do tratamento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _submitFuture = appatiteRepo.insertNewTreatment(
                            user,
                            startDate: selectedStartDate!,
                            expectedEndDate: selectedExpectedEndDate,
                            nameMedication: nameMedication,
                            patient: patient,
                            treatmentDuration: treatmentDuration,
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
                      return Text('Treatment saved successfully');
                    } else {
                      return Text('Failed to save treatment');
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


//todo nome de medicmento: Maviret(3 comprimidos por dia), epclusa(1 por dia)
//todo periodos de tratamento 8, 12, 16