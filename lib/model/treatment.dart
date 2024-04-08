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

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] as int,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      realEndDate: json['realEndDate'] != null ? DateTime.parse(json['realEndDate']) : null,
      expectedEndDate: json['expectedEndDate'] != null ? DateTime.parse(json['expectedEndDate']) : null,
      postTreatmentStartDate: json['postTreatmentStartDate'] != null ? DateTime.parse(json['postTreatmentStartDate']) : null,
      nameMedication: json['nameMedication'] as int?,
      reasonsDropout: json['reasonsDropout'] as int?,
      endTreatmentComment: json['endTreatmentComment'] as String?,
      comments: json['comments'] != null ? Comments.fromJson(json['comments']) : null,
      //diagnosisTest: json['diagnosisTest'] != null ? Test.fromJson(json['diagnosisTest']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate?.toIso8601String(),
      'realEndDate': realEndDate?.toIso8601String(),
      'expectedEndDate': expectedEndDate?.toIso8601String(),
      'postTreatmentStartDate': postTreatmentStartDate?.toIso8601String(),
      'nameMedication': nameMedication,
      'reasonsDropout': reasonsDropout,
      'endTreatmentComment': endTreatmentComment,
      'comments': comments?.toJson(),
      //'diagnosisTest': diagnosisTest?.toJson(),
    };
  }
}

@immutable
class Comments {
  final String? content;

  Comments({
    this.content,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
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


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // Add other properties as needed
    };
  }
}

@immutable
class Test {
  // Define your Test class here
  // This is just a placeholder, you need to define it based on your requirements
}
