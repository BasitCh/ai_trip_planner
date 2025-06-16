import 'package:fpdart/fpdart.dart';

abstract class IUploadRepository {
  Future<Either<Exception, List<String>>> uploadImages({
    required String basePath,
    required List<dynamic> images,
  });
}
