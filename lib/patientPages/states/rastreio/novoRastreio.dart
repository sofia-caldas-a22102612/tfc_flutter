import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'package:tfc_flutter/patientPages/states/DiagnosticsState/paginaEditarDiagnostico.dart';

class NovoRastreio extends StatefulWidget {
  final Patient patient;

  const NovoRastreio({Key? key, required this.patient}) : super(key: key);

  @override
  _NovoRastreioState createState() => _NovoRastreioState();
}

class _NovoRastreioState extends State<NovoRastreio> {
  bool? diagnosis;
  DateTime? testDate;
  DateTime? resultDate;
  bool? result;
  int? testLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Rastreio'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Teste Rastreio',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Resultado: '),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        diagnosis = true;
                      });
                    },
                    child: Text('Positivo'),
                    style: ElevatedButton.styleFrom(
                      primary: diagnosis == true ? Colors.green : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        diagnosis = false;
                      });
                    },
                    child: Text('Negativo'),
                    style: ElevatedButton.styleFrom(
                      primary: diagnosis == false ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data do Teste'),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      testDate = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data do Resultado'),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      resultDate = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Local do Teste'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    testLocation = int.tryParse(value);
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (diagnosis == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginaEditarDiagnostico(patient: widget.patient),
                      ),
                    );
                  } else {
                    // If the diagnosis is negative, navigate back to the previous page
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
}
