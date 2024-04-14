import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(explicitToJson: true)

class Comment {
  final int id;
  final DateTime? date;
  String? comment;


  Comment({
    required this.id,
    this.date,
    this.comment
  });


}
