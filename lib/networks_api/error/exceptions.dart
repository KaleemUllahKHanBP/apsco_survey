class ServerExpection {
  final String message;
  const ServerExpection(this.message);
}

class ServerExpectionWithCode {
  final String message;
  final int statusCode;
  const ServerExpectionWithCode(this.message, this.statusCode);
}

class LocationException {
  final String message;
  final String type;
  const LocationException(this.message, this.type);
}

class DeviceInfoException {
  final String message;
  const DeviceInfoException(this.message);
}

class LocalException {
  final String message;
  const LocalException(this.message);
}
