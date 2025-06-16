import 'package:dio/dio.dart';
import 'package:widgets_book/widgets_book.dart';

extension DioErrorX on DioException {
  ApiError toApiError() {
    final apiError = ApiError();
    String? errorMessage = '';
    String? code = '';
    if (response?.data != null && response!.data is Map) {
      code = response!.data['code'] as String?;
      errorMessage = response!.data['message'] as String?;
    } else {
      errorMessage = message;
    }
    return apiError.copyWith(
      code: code,
      message: errorMessage ?? '',
    );
  }
}
