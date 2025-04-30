class Failure {
  final String message;
  Failure([this.message = 'An unexpected error']);
  @override
  String toString() => message;
}
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}
