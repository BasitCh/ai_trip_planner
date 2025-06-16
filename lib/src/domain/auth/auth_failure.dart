class AuthFailure {
  T map<T>({
    required T Function(CancelledByUser) cancelledByUser,
    required T Function(ServerError) serverError,
    required T Function(EmailAlreadyInUse) emailAlreadyInUse,
    required T Function(InvalidEmailAndPasswordCombination)
        invalidEmailAndPasswordCombination,
  }) {
    if (this is CancelledByUser) {
      return cancelledByUser(this as CancelledByUser);
    } else if (this is ServerError) {
      return serverError(this as ServerError);
    } else if (this is EmailAlreadyInUse) {
      return emailAlreadyInUse(this as EmailAlreadyInUse);
    } else if (this is InvalidEmailAndPasswordCombination) {
      return invalidEmailAndPasswordCombination(
        this as InvalidEmailAndPasswordCombination,
      );
    } else {
      throw AssertionError('Unknown AuthFailure type: $this');
    }
  }
}

class AuthByPhoneFailure {
  T map<T>({
    required T Function(CancelledByUser) cancelledByUser,
    required T Function(ServerError) serverError,
  }) {
    if (this is CancelledByUser) {
      return cancelledByUser(this as CancelledByUser);
    } else if (this is ServerError) {
      return serverError(this as ServerError);
    } else {
      throw AssertionError('Unknown AuthFailure type: $this');
    }
  }
}

class CancelledByUser extends AuthFailure {}

class ServerError extends AuthFailure {}

class EmailAlreadyInUse extends AuthFailure {}

class InvalidEmailAndPasswordCombination extends AuthFailure {}
