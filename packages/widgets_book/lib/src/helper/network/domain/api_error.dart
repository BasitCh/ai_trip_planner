class ApiError {

  ApiError({
    this.code,
    this.message,
});
  String? code;
  String? message;

  ApiError copyWith({
    String? code,
    String? message,
})=> ApiError(
    code: code,
    message: message,
  );
}

ApiError userNotFoundError() => ApiError(message: 'User not found!');

ApiError serverError() => ApiError(message: 'Server error');

ApiError unauthorizedError() => ApiError(message: 'Unauthorized error');
