import 'package:fpdart/fpdart.dart';

import '../error/data_state.dart';

///[UseCase] is a generic class that represents a use case in the application.
///use cases extends this class to define a specific use case.
///It takes a generic type [Type] and a generic type [Params]
///It returns a future of either a [Failure] or a [Type]
abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

/// [UseCaseWithOutFuture] is a generic class that represents a use case in the application.
/// It does not return a future.
///use cases extends this class to define a specific use case.
abstract class UseCaseWithOutFuture<Type, Params> {
  Either<Failure, Type> call(Params params);
}

///[NoParams] is a class that represents no parameters
final class NoParams {}