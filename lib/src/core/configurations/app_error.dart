class AppError extends Error {
  final String message;

  AppError({this.message = 'An error occurred'});

  factory AppError.network() => AppNetworkError();

  factory AppError.dataSource() => AppDataSourceError();

  factory AppError.parsing() => AppParsingError();

  @override
  String toString() => 'AppError: $message';
}

class AppDataSourceError extends AppError {
  AppDataSourceError();

  @override
  String toString() => 'AppDataSourceError: $message';
}

class AppNetworkError extends AppError {
  AppNetworkError();

  @override
  String toString() => 'AppNetworkError: $message';
}

class AppParsingError extends AppError {
  AppParsingError();

  @override
  String toString() => 'AppRepositoryError: $message';
}
