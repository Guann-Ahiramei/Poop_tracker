import 'package:flutter/cupertino.dart';

class Goal {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? moodNote;
  final bool completed;
  final int energy;
  final IconData? icon;
  final int order;

  Goal({
    required this.id,
    required this.title,
    required this.startTime,
    this.endTime,
    this.moodNote,
    this.completed = false,
    this.energy = 0,
    this.icon,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'moodNote': moodNote,
      'completed': completed,
      'energy': energy,
      'order': order,
      'iconCode': icon?.codePoint,
      'iconFontFamily': icon?.fontFamily,
      'iconFontPackage': icon?.fontPackage,
    };
  }

  static Goal fromMap(String id, Map<String, dynamic> map) {
    return Goal(
      id: id,
      title: map['title'] ?? '',
      startTime: DateTime.parse(map['startTime']),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      moodNote: map['moodNote'],
      completed: map['completed'] ?? false,
      energy: map['energy'] ?? 0,
      order: map['order'] ?? 0,
      icon: map['iconCode'] != null
          ? IconData(map['iconCode'], fontFamily: map['iconFontFamily'], fontPackage: map['iconFontPackage'])
          : null,
    );
  }
}
