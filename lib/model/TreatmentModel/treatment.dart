import 'package:tfc_flutter/model/TreatmentModel/dailyMedicine.dart';

class Treatment {
  final int _id;
  final DateTime? _startDate;
  final DateTime? _realEndDate; // Add realEndDate
  final DateTime? _postTreatmentStartDate; // Add postTreatmentStartDate
  final String? _nameMedication; // Change type to String
  final String? _reasonsDropout; // Change type to String
  final String? _endTreatmentComment;
  final int? _treatmentDuration;
  final int? _patientId;
  List<DailyMedicine>? _dailyMedicine;

  Treatment({
    required int id,
    DateTime? startDate,
    DateTime? realEndDate,
    DateTime? postTreatmentStartDate,
    String? nameMedication,
    String? reasonsDropout,
    String? endTreatmentComment,
    int? treatmentDuration,
    required int patientId,
    List<DailyMedicine>? dailyMedicine,
  })  : _id = id,
        _startDate = startDate,
        _realEndDate = realEndDate,
        _postTreatmentStartDate = postTreatmentStartDate,
        _nameMedication = nameMedication,
        _reasonsDropout = reasonsDropout,
        _endTreatmentComment = endTreatmentComment,
        _treatmentDuration = treatmentDuration,
        _patientId = patientId,
        _dailyMedicine = dailyMedicine;



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate?.toIso8601String(),
      'realEndDate': realEndDate?.toIso8601String(),
      'postTreatmentStartDate': postTreatmentStartDate?.toIso8601String(),
      'nameMedication': nameMedication,
      'reasonsDropout': reasonsDropout,
      'endTreatmentComment': endTreatmentComment,
      'treatmentDuration': treatmentDuration,
      'patientId': patientId,
      'dailyMedicine': dailyMedicine?.map((medicine) => medicine.toJson()).toList(),
    };
  }


  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      realEndDate: json['realEndDate'] != null ? DateTime.parse(json['realEndDate'] as String) : null,
      postTreatmentStartDate: json['postTreatmentStartDate'] != null ? DateTime.parse(json['postTreatmentStartDate'] as String) : null,
      nameMedication: json['nameMedication'] as String?,
      reasonsDropout: json['reasonsDropout'] as String?,
      endTreatmentComment: json['endTreatmentComment'] as String?,
      treatmentDuration: json['treatmentDuration'] as int?,
      patientId: json['patientId'] as int,
      dailyMedicine: (json['dailyMedicine'] as List<dynamic>?)
          ?.map((medicine) => DailyMedicine.fromJson(medicine as Map<String, dynamic>))
          .toList(),
    );
  }


  int get id => _id;
  DateTime? get startDate => _startDate;
  DateTime? get realEndDate => _realEndDate;
  DateTime? get postTreatmentStartDate => _postTreatmentStartDate;
  String? get nameMedication => _nameMedication;
  String? get reasonsDropout => _reasonsDropout;
  String? get endTreatmentComment => _endTreatmentComment;
  int? get treatmentDuration => _treatmentDuration;
  int? get patientId => _patientId;
  List<DailyMedicine>? get dailyMedicine => _dailyMedicine;
}
