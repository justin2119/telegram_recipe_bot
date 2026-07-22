class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}
