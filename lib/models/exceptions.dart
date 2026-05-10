sealed class AppError implements Exception {
  final String message;
  const AppError(this.message);

  @override
  String toString() => message;
}

class ValidationError extends AppError {
  const ValidationError(super.message);
}
