class AppStrings {
  const AppStrings._();

  static const appTitle = 'Student Gradebook';
  static const myGrades = 'My Grades';
  static const overallAverage = 'Overall Average';
  static const subjects = 'Subjects';
  static const allGrades = 'All Grades';

  static const addSubject = 'Add Subject';
  static const add = 'Add';
  static const cancel = 'Cancel';
  static const select = 'Select';

  static const subjectName = 'Subject Name';
  static const iconEmoji = 'Icon (Emoji)';
  static const gradeScore = 'Grade (0-100)';
  static const gradeType = 'Type';
  static const description = 'Description';

  static const noDataYet = 'No data yet';
  static const tapPlusToAdd = 'Tap + to add';
  static const noGradesFound = 'No grades found';
  static const changeFiltersOrAdd = 'Change filters or tap + to add';

  static const gradeDeleted = 'Grade deleted';
  static const statusAll = 'Status: All';
  static const typeAll = 'Type: All';
  static const sortNewest = 'Sort: Newest';
  static const sortOldest = 'Sort: Oldest';
  static const sortHighest = 'Sort: Highest';
  static const sortLowest = 'Sort: Lowest';
  static const averageHighestFirst = 'Average (Highest first)';
  static const averageLowestFirst = 'Average (Lowest first)';

  static String addGradeTo(String subjectName) => 'Add Grade to $subjectName';

  static String averageValue(double average) {
    return 'Average: ${average.toStringAsFixed(1)}';
  }

  static String dateValue(String date) => 'Date: $date';

  static String gradesCount(int count) {
    return count == 1 ? '1 grade' : '$count grades';
  }
}
