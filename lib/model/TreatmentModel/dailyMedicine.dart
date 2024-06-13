class DailyMedicine {
  final int id;
  final DateTime date;
  final bool tookMedicine;
  final bool? takeAtHome;
  final String? notes;

  DailyMedicine({
    required this.id,
    DateTime? date,
    this.tookMedicine = false,
    this.takeAtHome,
    this.notes,
  }) : date = date ?? DateTime.now();

  factory DailyMedicine.fromJson(Map<String, dynamic> json) {
    return DailyMedicine(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      date: DateTime.parse(json['date'] as String),
      tookMedicine: json['tookMedicine'] as bool,
      takeAtHome: json['takeAtHome'] as bool?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'tookMedicine': tookMedicine,
      'takeAtHome': takeAtHome,
      'notes': notes,
    };
  }
}
