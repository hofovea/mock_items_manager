sealed class Failure {
  String? description;

  Failure({this.description});
}

class UserMissingFailure extends Failure {
  UserMissingFailure({super.description});
}

class UserAlreadyExistsFailure extends Failure {
  UserAlreadyExistsFailure({super.description});
}

class ServerInternalFailure extends Failure {
  ServerInternalFailure({super.description});
}

class ServerUnavailableFailure extends Failure {
  ServerUnavailableFailure({super.description});
}

class InvalidResponseFailure extends Failure {
  InvalidResponseFailure({super.description});
}
class UnknownFailure extends Failure {
  UnknownFailure({super.description});
}
