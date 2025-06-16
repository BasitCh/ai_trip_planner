part of 'login_register_cubit.dart';

class LoginRegisterState extends Equatable {
  const LoginRegisterState(
      {this.isPasswordObscure = true,
      this.isEmailAddressValidated = false,
      this.isPasswordValidated = false,
      this.isTermsAgreed,
      this.passwordValidationState,
      this.authFailureOrSuccessOption,
      this.isSubmitting = false,
      this.isSocial = false});

  LoginRegisterState copyWith(
          {bool? isPasswordObscure,
          bool? isTermsAgreed,
          bool? isEmailAddressValidated,
          bool? isPasswordValidated,
          PasswordValidationState? passwordState,
          Option<Either<ApiError, User?>>? authFailureOrSuccessOption,
          bool? isSubmitting, bool? isSocial}) =>
      LoginRegisterState(
          isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
          isTermsAgreed: isTermsAgreed ?? this.isTermsAgreed,
          isEmailAddressValidated: isEmailAddressValidated ?? this.isEmailAddressValidated,
          isPasswordValidated: isPasswordValidated ?? this.isPasswordValidated,
          passwordValidationState: passwordState ?? passwordValidationState,
          authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
          isSubmitting: isSubmitting ?? this.isSubmitting,isSocial: isSocial?? this.isSocial);

  bool isFormValid(GlobalKey<FormState> formKey) {
    final formState = formKey.currentState;
    return formState != null && formState.validate() && isPasswordValidated;
  }

  final bool isPasswordObscure;
  final bool? isTermsAgreed;
  final bool isEmailAddressValidated;
  final bool isPasswordValidated;
  final PasswordValidationState? passwordValidationState;
  final Option<Either<ApiError, User?>>? authFailureOrSuccessOption;
  final bool isSubmitting;
  final bool isSocial;

  @override
  List<Object?> get props => [
        isPasswordObscure,
        isTermsAgreed,
        isEmailAddressValidated,
        isPasswordValidated,
        passwordValidationState,
        authFailureOrSuccessOption,
        isSubmitting
      ];
}

class PasswordValidationState extends Equatable {
  const PasswordValidationState({this.hasMinLength = false, this.hasUpperCase = false, this.hasLowerCase = false, this.hasNumber = false});

  PasswordValidationState copyWith({bool? hasMinLength, bool? hasUpperCase, bool? hasLowerCase, bool? hasNumber}) {
    return PasswordValidationState(
        hasMinLength: hasMinLength ?? this.hasMinLength,
        hasUpperCase: hasUpperCase ?? this.hasUpperCase,
        hasLowerCase: hasLowerCase ?? this.hasLowerCase,
        hasNumber: hasNumber ?? this.hasNumber);
  }

  final bool hasMinLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumber;

  @override
  List<Object?> get props => [hasMinLength, hasUpperCase, hasLowerCase, hasNumber];
}
