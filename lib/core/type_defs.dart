import 'dart:ffi';
import 'package:fpdart/fpdart.dart';
import 'core.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<Void?>;
typedef FutureVoid = Future<Void>;
