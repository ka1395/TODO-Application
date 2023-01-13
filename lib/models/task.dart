// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  Task(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    json['id'] = json['id'];
    json['title'] = json['title'];
    json['note'] = json['note'];
    json['isCompleted'] = json['isCompleted'];
    json['date'] = json['date'];
    json['startTime'] = json['startTime'];
    json['endTime'] = json['endTime'];
    json['color'] = json['color'];
    json['remind'] = json['remind'];
    json['repeat'] = json['repeat'];
  }
}
