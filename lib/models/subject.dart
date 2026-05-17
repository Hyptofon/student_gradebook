import 'exceptions.dart';
import 'grade.dart';
import 'grade_status.dart';

class Subject {
  final int id;
  final String name;
  final String icon;
  final List<Grade> _grades;

  Subject({
    required this.id,
    required String name,
    required String icon,
    List<Grade> grades = const [],
  }) : name = _validateString(name, fieldName: 'Name'),
       icon = _validateString(icon, fieldName: 'Icon'),
       _grades = List.unmodifiable(grades);

  static String _validateString(String value, {required String fieldName}) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      throw ValidationError('$fieldName cannot be empty');
    }
    return trimmedValue;
  }

  List<Grade> get grades => List.unmodifiable(_grades);

  double get average => _grades.isEmpty
      ? 0.0
      : _grades.fold<double>(0.0, (sum, grade) => sum + grade.score) /
            _grades.length;

  GradeStatus get status =>
      _grades.isEmpty ? GradeStatus.noData : GradeStatus.fromScore(average);

  int get stars => starsForAverage(average, hasGrades: _grades.isNotEmpty);

  static int starsForAverage(double average, {required bool hasGrades}) {
    if (!hasGrades) {
      return 0;
    }

    return switch (average) {
      >= 91 => 5,
      >= 76 => 4,
      >= 61 => 3,
      _ => 2,
    };
  }

  Subject copyWith({String? name, String? icon, List<Grade>? grades}) {
    return Subject(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      grades: grades ?? _grades,
    );
  }
}
