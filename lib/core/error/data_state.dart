/// [Failure] is a class that represents a failure in the application.
/// Its an sealed class that cannot initialize but can be extended.
sealed class Failure {
  final String message;

  const Failure([this.message = '']);
}

/// [ServerFailure] is a class that represents a server failure in the application.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}

/// [ApiFailure] is a class that represents a api failure in the application.
class ApiFailure extends Failure {
  const ApiFailure([super.message = 'Api Failure']);
}

/// [HiveFailure] is a class that represents a database[hive] failure in the application.
class HiveFailure extends Failure {
  const HiveFailure([super.message = 'Hive Database Failure']);
}

/// [DriftFailure] is a class that represents a database[drift] failure in the application.
class DriftFailure extends Failure {
  const DriftFailure([super.message = 'Drift Database Failure']);
}

/// [CacheFailure] is a class that represents a cache failure in the application.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Failure']);
}

/// [UnknownFailure] is a class that represents an unknown failure in the application.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unknown Failure']);
}

/// [CustomFailure] is a class that represents a custom failure in the application.
class CustomFailure extends Failure {
  const CustomFailure([super.message = 'Unknown Failure']);
}
