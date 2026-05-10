import 'grade.dart';
import 'grade_status.dart';
import 'grade_type.dart';

enum GradeSortOption { dateDesc, dateAsc, scoreDesc, scoreAsc }

enum StatusFilter { all, a, b, c, d, e, fx, f }

extension StatusFilterRules on StatusFilter {
  GradeStatus? get status => switch (this) {
    StatusFilter.all => null,
    StatusFilter.a => GradeStatus.a,
    StatusFilter.b => GradeStatus.b,
    StatusFilter.c => GradeStatus.c,
    StatusFilter.d => GradeStatus.d,
    StatusFilter.e => GradeStatus.e,
    StatusFilter.fx => GradeStatus.fx,
    StatusFilter.f => GradeStatus.f,
  };

  bool matches(Grade grade) {
    final selectedStatus = status;
    return selectedStatus == null || grade.status == selectedStatus;
  }
}

enum TypeFilter { all, exam, quiz, homework, project }

extension TypeFilterRules on TypeFilter {
  GradeType? get type => switch (this) {
    TypeFilter.all => null,
    TypeFilter.exam => GradeType.exam,
    TypeFilter.quiz => GradeType.quiz,
    TypeFilter.homework => GradeType.homework,
    TypeFilter.project => GradeType.project,
  };

  bool matches(Grade grade) {
    final selectedType = type;
    return selectedType == null || grade.type == selectedType;
  }
}
