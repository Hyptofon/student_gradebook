import '../models/grade_filters.dart';
import '../models/grade_status.dart';
import '../models/grade_type.dart';
import '../providers/gradebook_provider.dart';
import 'app_strings.dart';

extension SubjectSortOptionLabel on SubjectSortOption {
  String get label => switch (this) {
    SubjectSortOption.averageDesc => AppStrings.averageHighestFirst,
    SubjectSortOption.averageAsc => AppStrings.averageLowestFirst,
  };
}

extension GradeSortOptionLabel on GradeSortOption {
  String get label => switch (this) {
    GradeSortOption.dateDesc => AppStrings.sortNewest,
    GradeSortOption.dateAsc => AppStrings.sortOldest,
    GradeSortOption.scoreDesc => AppStrings.sortHighest,
    GradeSortOption.scoreAsc => AppStrings.sortLowest,
  };
}

extension StatusFilterLabel on StatusFilter {
  String get label => switch (this) {
    StatusFilter.all => AppStrings.statusAll,
    StatusFilter.a => GradeStatus.a.label,
    StatusFilter.b => GradeStatus.b.label,
    StatusFilter.c => GradeStatus.c.label,
    StatusFilter.d => GradeStatus.d.label,
    StatusFilter.e => GradeStatus.e.label,
    StatusFilter.fx => GradeStatus.fx.label,
    StatusFilter.f => GradeStatus.f.label,
  };
}

extension TypeFilterLabel on TypeFilter {
  String get label => switch (this) {
    TypeFilter.all => AppStrings.typeAll,
    TypeFilter.exam => GradeType.exam.label,
    TypeFilter.quiz => GradeType.quiz.label,
    TypeFilter.homework => GradeType.homework.label,
    TypeFilter.project => GradeType.project.label,
  };
}
