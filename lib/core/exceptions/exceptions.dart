sealed class CoreException implements Exception {
  final String? message;

  CoreException([this.message]);
}

class InvalidDataException extends CoreException {
  InvalidDataException([super.message]);
}

class ServerInternalException extends CoreException {
  ServerInternalException([super.message]);
}

class UnknownException extends CoreException {
  UnknownException([super.message]);
}
