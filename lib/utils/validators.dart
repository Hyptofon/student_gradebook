class Validators {
  const Validators._();

  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? grade(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Grade is required';
    }
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed < 0 || parsed > 100) {
      return 'Grade must be between 0 and 100';
    }
    return null;
  }

  static double? tryParseGrade(String? value) {
    if (value == null) {
      return null;
    }
    return double.tryParse(value.trim());
  }

  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (value) => validators.fold<String?>(
      null,
      (error, validator) => error ?? validator(value),
    );
  }
}
