import 'package:meta/meta.dart'; // Import 'meta' package for @immutable annotation

@immutable
class Treatment {
  final int id;
  final DateTime? startDate;
  DateTime? realEndDate;
  final DateTime? expectedEndDate;
  DateTime? postTreatmentStartDate;
  final int? nameMedication;
  int? reasonsDropout;
  String? endTreatmentComment;
  Comments? comments;
  Test? diagnosisTest;

  Treatment({
    required this.id,
    this.startDate,
    this.realEndDate,
    this.expectedEndDate,
    this.postTreatmentStartDate,
    this.nameMedication,
    this.reasonsDropout,
    this.endTreatmentComment,
    this.comments,
    this.diagnosisTest,
  });

  // String getters for variables
  String get startDateAsString => startDate?.toIso8601String() ?? '';
  String get realEndDateAsString => realEndDate?.toIso8601String() ?? '';
  String get expectedEndDateAsString => expectedEndDate?.toIso8601String() ?? '';
  String get postTreatmentStartDateAsString => postTreatmentStartDate?.toIso8601String() ?? '';
  String get nameMedicationAsString => nameMedication?.toString() ?? '';
  String get reasonsDropoutAsString => reasonsDropout?.toString() ?? '';
  String get endTreatmentCommentAsString => endTreatmentComment ?? '';
}

@immutable
class Comments {
  final String? content;

  Comments({
    this.content,
  });

  // String getter for content
  String get contentAsString => content ?? '';
}

@immutable
class Patient {
  final int id;
  final String name;
  // Add other properties as needed

  Patient({
    required this.id,
    required this.name,
    // Add other properties as needed
  });

  // String getter for name
  String get nameAsString => name;
}

@immutable
class Test {
  // Define your Test class here
  // This is just a placeholder, you need to define it based on your requirements
}

