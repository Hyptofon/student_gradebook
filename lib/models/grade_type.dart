import 'package:flutter/material.dart';

enum GradeType { exam, quiz, homework, project }

extension GradeTypeExtension on GradeType {
  String get label => switch (this) {
    GradeType.exam => 'Exam',
    GradeType.quiz => 'Quiz',
    GradeType.homework => 'Homework',
    GradeType.project => 'Project',
  };

  IconData get icon => switch (this) {
    GradeType.exam => Icons.description,
    GradeType.quiz => Icons.quiz,
    GradeType.homework => Icons.book,
    GradeType.project => Icons.folder,
  };
}
