class Treatment {
  final int id;
  final String startDate;
  final String? realEndDate;
  final String? postTreatmentStartDate;
  final int? nameMedication;
  final int? reasonsDropout;
  final String? endTreatmentComment;
  final int? treatmentDuration;
  final int? patientId;

  Treatment({
    required this.id,
    required this.startDate,
    this.realEndDate,
    this.postTreatmentStartDate,
    this.nameMedication,
    this.reasonsDropout,
    this.endTreatmentComment,
    this.treatmentDuration,
    this.patientId,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int,
      startDate: json['startDate'] as String,
      realEndDate: json['realEndDate'] as String?,
      postTreatmentStartDate: json['postTreatmentStartDate'] as String?,
      nameMedication: json['nameMedication'] as int?,
      reasonsDropout: json['reasonsDropout'] as int?,
      endTreatmentComment: json['endTreatmentComment'] as String?,
      treatmentDuration: json['treatmentDuration'] as int?,
      patientId: json['patientId'] as int?,
    );
  }
}




/*
class DailyMedicine {
  final int id;
  final String date;
  final bool tookMedicine;
  final bool takeAtHome;
  final String? notes;
  final Treatment? treatment;

  DailyMedicine({
    required this.id,
    required this.date,
    required this.tookMedicine,
    this.takeAtHome = false,
    this.notes,
    this.treatment,
  });

  factory DailyMedicine.fromJson(Map<String, dynamic> json) {
    return DailyMedicine(
      id: json['id'],
      date: json['date'] as String,
      tookMedicine: json['took_medicine'] as bool,
      takeAtHome: json['to_take_at_home'] as bool? ?? false,
      notes: json['notes'] as String?,
      treatment: json['treatment'] != null
          ? Treatment.fromJson(json['treatment'] as Map<String, dynamic>)
          : null,
    );
  }
}

 */
