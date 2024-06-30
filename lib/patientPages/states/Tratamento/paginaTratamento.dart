import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tfc_flutter/model/TreatmentModel/treatment.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';

class PaginaTratamento extends StatefulWidget {
  const PaginaTratamento({Key? key}) : super(key: key);

  @override
  _PaginaTratamentoState createState() => _PaginaTratamentoState();
}

class _PaginaTratamentoState extends State<PaginaTratamento> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedIndex = 0;
  final TextEditingController _notesController = TextEditingController();

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session>();
    final patient = session.patient;
    final user = session.user;

    if (patient == null || user == null) {
      return Scaffold(
        body: Center(
          child: Text('No patient or user information available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ToggleButtons(
                isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                onPressed: _onToggle,
                selectedColor: Colors.white,
                color: Colors.white70,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Detalhes do Tratamento',
                      style: TextStyle(
                        fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Calendário de Tomás',
                      style: TextStyle(
                        fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Treatment?>(
        future: context.read<AppatiteRepository>().getCurrentTreatment(user, patient.getIdZeus()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No current treatment found'));
          } else {
            final currentTreatment = snapshot.data!;
            return _selectedIndex == 0
                ? _buildTreatmentDetails(currentTreatment)
                : _buildTreatmentCalendar(currentTreatment);
          }
        },
      ),
    );
  }

  Widget _buildTreatmentDetails(Treatment treatment) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes do Tratamento',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20),
          Text('Data de Início: ${treatment.startDate}'),
          SizedBox(height: 20),
          Text('Medicamento: ${treatment.medicationName ?? 'Não especificado'}'),
          SizedBox(height: 20),
          Text('Duração: ${treatment.treatmentDuration ?? 'Indefinido'} semanas'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the edit screen or show edit dialog
              _showEditDialog(context, treatment);
            },
            child: Text('Editar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentCalendar(Treatment treatment) {
    final startDate = DateTime.parse(treatment.startDate);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calendário do Tratamento',
            style: TextStyle(fontSize: 24),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showConfirmationDialog(context);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              if (day.isAtSameMomentAs(startDate)) {
                return ['Início do Tratamento'];
              }
              // Add other events based on the treatment data if needed
              return [];
            },
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event) {
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Toma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notas',
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
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
                backgroundColor: Colors.red[900], // Dark red color
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Treatment treatment) {
    // Add logic for editing the treatment details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Detalhes do Tratamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: treatment.startDate,
                decoration: InputDecoration(
                  labelText: 'Data de Início',
                ),
              ),
              TextFormField(
                initialValue: treatment.medicationName,
                decoration: InputDecoration(
                  labelText: 'Medicamento',
                ),
              ),
              TextFormField(
                initialValue: treatment.treatmentDuration?.toString(),
                decoration: InputDecoration(
                  labelText: 'Duração (semanas)',
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
                'Cancelar',
                style: TextStyle(
                  color: Colors.white, // White color
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[900], // Dark red color
              ),
            ),
            TextButton(
              onPressed: () {
                // Save the changes
                Navigator.pop(context); // Close the popup
              },
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.white, // White color
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[900], // Dark green color
              ),
            ),
          ],
        );
      },
    );
  }
}
