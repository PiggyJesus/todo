class NoInternetException implements Exception {
  final String message;

  NoInternetException({this.message = 'No internet connection'});

  @override
  String toString() => 'NoInternetException: $message';
}

class ResponseException implements Exception {
  final String message;

  ResponseException(this.message);

  @override
  String toString() => 'ResponseException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = 'Unknown network error'});

  @override
  String toString() => 'UnknownNetworkException: $message';
}
