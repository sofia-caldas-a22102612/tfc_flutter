import 'package:flutter/material.dart';
import 'package:tfc_flutter/model/test.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import 'package:tfc_flutter/model/session.dart';

class TestInfoPage extends StatelessWidget {
  final Test test;

  const TestInfoPage({Key? key, required this.test}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appatiteRepository = context.read<AppatiteRepository>();
    final session = context.read<Session>();
    final user = session.user;
    final patient = session.patient;

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Test Type: ${test.getTypeString()}'),
            Text('Test Date: ${test.getTestDate().toString()}'),
            Text('Result: ${test.getResult() ?? ''}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the edit action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditTestPage(test: test)),
                );
              },
              child: Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTestPage extends StatefulWidget {
  final Test test;

  const EditTestPage({Key? key, required this.test}) : super(key: key);

  @override
  _EditTestPageState createState() => _EditTestPageState();
}

class _EditTestPageState extends State<EditTestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late DateTime selectedTestDate;
  late DateTime selectedResultDate;
  late bool result;

  @override
  void initState() {
    super.initState();
    selectedTestDate = widget.test.getTestDate()!;
    selectedResultDate = widget.test.getResultDate()!;
    result = widget.test.getResult()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: selectedTestDate.toString(),
                decoration: InputDecoration(labelText: 'Test Date'),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedTestDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedTestDate = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (selectedTestDate == null) {
                    return 'Select test date';
                  }
                  return null;
                },
                readOnly: true,
              ),
              TextFormField(
                initialValue: selectedResultDate.toString(),
                decoration: InputDecoration(labelText: 'Result Date'),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedResultDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedResultDate = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (selectedResultDate == null) {
                    return 'Select result date';
                  }
                  return null;
                },
                readOnly: true,
              ),
              SwitchListTile(
                title: Text('Result'),
                value: result,
                onChanged: (bool value) {
                  setState(() {
                    result = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle saving the edited test
                    // appatiteRepository.saveEditedTest(...);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
