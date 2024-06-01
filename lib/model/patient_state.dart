class PatientState {
  String status;
  DateTime? statusDate;

  PatientState(this.status, this.statusDate);

  PatientState.fromJson(Map<String, dynamic> json)
      : status = (json['status'] as String).toUpperCase(),
        statusDate = json['statusDate'] != null ? DateTime.parse(json['statusDate'] as String) : null;
}