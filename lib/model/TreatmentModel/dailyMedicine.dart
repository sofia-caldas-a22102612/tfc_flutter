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
  }) : date = date ?? DateTime.now(); // If date is null, initialize with current DateTime

  DailyMedicine.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? int.parse(json['id'].toString()) : 0,
        date = DateTime.parse(json['date']),
        tookMedicine = json['tookMedicine'] == true,
        takeAtHome = json['takeAtHome'] == true,
        notes = json['notes'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'tookMedicine': tookMedicine,
    'takeAtHome': takeAtHome,
    'notes': notes,
  };
}