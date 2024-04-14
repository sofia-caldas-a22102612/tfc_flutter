import '../test.dart';
import 'comment.dart';


class Treatment {
  final int id;
  final DateTime? startDate;
  DateTime? realEndDate;
  final DateTime? expectedEndDate;
  DateTime? postTreatmentStartDate;
  final int? nameMedication;
  int? reasonsDropout;
  String? endTreatmentComment;
  List<Comment>? comments;
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
    //this.comments,
    this.diagnosisTest,
  });


  Treatment.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'] as String),
        startDate = DateTime.parse(json['startDate'] as String),
        realEndDate = DateTime.parse(json['realEndDate'] as String),
        expectedEndDate = DateTime.parse(json['expectedEndDate'] as String),
        postTreatmentStartDate = DateTime.parse(json['postTreatmentStartDate'] as String),
        nameMedication = int.parse(json['nameMedication'] as String),
        reasonsDropout = int.parse(json['reasonsDropout'] as String),
        endTreatmentComment = json['endTreatmentComment'] as String;
        //comments = json['comments'] as String,
        //diagnosisTest = json['diagnosisTest'] as String;



  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'startDate': startDate,
        'realEndDate': realEndDate,
        'expectedEndDate': expectedEndDate,
        'postTreatmentStartDate': postTreatmentStartDate,
        'nameMedication': nameMedication,
        'reasonsDropout': reasonsDropout,
        'endTreamentComment': endTreatmentComment,
        //'comments': comments,
        //'diagnosisTest': diagnosisTest
      };


}
