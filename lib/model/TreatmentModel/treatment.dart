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
      startDate: json['start_date'] as String? ?? '',
      realEndDate: json['real_end_date'] as String?,
      postTreatmentStartDate: json['post_treatment_start_date'] as String?,
      nameMedication: json['name_medication'] as int?,
      reasonsDropout: json['reasons_dropout'] as int?,
      endTreatmentComment: json['end_treatment_comments'] as String?,
      treatmentDuration: json['treatment_duration'] as int?,
      patientId: json['patient_id'] as int?,
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
