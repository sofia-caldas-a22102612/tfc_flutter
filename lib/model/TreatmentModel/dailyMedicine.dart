class DailyMedicine {
  final int id;
  final DateTime date;
  final bool tookMedicine;
  final bool takeAtHome;
  final String? notes;

  DailyMedicine({
    required this.id,
    required this.date,
    required this.tookMedicine,
    required this.takeAtHome,
    this.notes,
  });

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