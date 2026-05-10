import 'exceptions.dart';
import 'grade_status.dart';
import 'grade_type.dart';

class Grade {
  final int id;
  final double score;
  final GradeType type;
  final String description;
  final DateTime date;

  Grade({
    required this.id,
    required double score,
    required this.type,
    required String description,
    required this.date,
  }) : score = _validateScore(score),
       description = _validateDescription(description);

  static double _validateScore(double value) {
    if (value < 0 || value > 100) {
      throw ValidationError('Score must be between 0 and 100');
    }
    return value;
  }

  static String _validateDescription(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      throw ValidationError('Description cannot be empty');
    }
    return trimmedValue;
  }

  String get scoreText => score.toStringAsFixed(0);

  GradeStatus get status => GradeStatus.fromScore(score);
}
