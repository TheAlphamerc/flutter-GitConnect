class SchemeConsistencyException implements Exception {
  final String message;

  SchemeConsistencyException([this.message = 'Schemes consistency error']);

  String toString() {
    if (message == null) return '$SchemeConsistencyException';
    return '$SchemeConsistencyException: $message';
  }
}

abstract class DiagnosticMessageException implements Exception {
  String get diagnosticMessage;
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class ApiInternalServerException extends ApiException {
  ApiInternalServerException()
      : super(
          'Internal Server Error');
}

class ApiDataNotFoundException extends ApiException {
  ApiDataNotFoundException()
      : super('Data Not Found Error');
}

class HttpException implements Exception {
  final _message;

  HttpException(this._message);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException(String message)
      : super("Error During Communication: $message");
}

class BadRequestException extends HttpException {
  BadRequestException(String message) : super("Invalid Request: $message");
}

class BadUrlException extends HttpException {
  BadUrlException(String message) : super("Bad URL: $message");
}

class UnauthorisedException extends HttpException {
  UnauthorisedException(String message) : super("Unauthorised: $message");
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException(String message) : super("Not found: $message");
}

class InvalidInputException extends HttpException {
  InvalidInputException(String message) : super("Invalid Input: $message");
}