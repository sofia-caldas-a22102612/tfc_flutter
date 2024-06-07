import 'package:tfc_flutter/model/TreatmentModel/dailyMedicine.dart';

class Treatment {
  final int _id;
  final DateTime? _startDate;
  final DateTime? _expectedEndDate;
  final int? _nameMedication;
  final int? _patientId;
  final int? _treatmentDuration;
  List<DailyMedicine>? _dailyMedicine;

  Treatment({
    required int id,
    DateTime? startDate,
    DateTime? expectedEndDate,
    int? nameMedication,
    required int patientId,
    int? treatmentDuration,
    List<DailyMedicine>? dailyMedicine,
  })  : _id = id,
        _startDate = startDate,
        _expectedEndDate = expectedEndDate,
        _nameMedication = nameMedication,
        _patientId = patientId,
        _treatmentDuration = treatmentDuration,
        _dailyMedicine = dailyMedicine;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'startDate': _startDate?.toIso8601String(),
      'expectedEndDate': _expectedEndDate?.toIso8601String(),
      'nameMedication': _nameMedication,
      'patientId': _patientId,
      'treatmentDuration': _treatmentDuration,
      'dailyMedicine': _dailyMedicine?.map((medicine) => medicine.toJson()).toList(),
    };
  }

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      expectedEndDate: json['expectedEndDate'] != null ? DateTime.parse(json['expectedEndDate'] as String) : null,
      nameMedication: json['nameMedication'] as int?,
      patientId: json['patientId'] as int,
      treatmentDuration: json['treatmentDuration'] as int?,
      dailyMedicine: (json['dailyMedicine'] as List<dynamic>?)
          ?.map((medicine) => DailyMedicine.fromJson(medicine as Map<String, dynamic>))
          .toList(),
    );
  }


  int get id => _id;
  DateTime? get startDate => _startDate;
  DateTime? get expectedEndDate => _expectedEndDate;
  int? get nameMedication => _nameMedication;
  int? get patientId => _patientId;
  int? get treatmentDuration => _treatmentDuration;
  List<DailyMedicine>? get dailyMedicine => _dailyMedicine;
}
