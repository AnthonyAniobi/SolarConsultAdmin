import 'package:admin/core/data/models/app_error.dart';
import 'package:either_dart/either.dart';

typedef AsyncErrorOr<T> = Either<AppError, T>;

class AppConfig {}