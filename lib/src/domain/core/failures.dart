class ValueFailure<T> {
  const ValueFailure();

  factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) {
    return ExceedingLength<T>(
      failedValue: failedValue,
      max: max,
    );
  }

  factory ValueFailure.empty({
    required T failedValue,
  }) {
    return Empty<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.multiline({
    required T failedValue,
  }) {
    return Multiline<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) {
    return ListTooLong<T>(
      failedValue: failedValue,
      max: max,
    );
  }

  factory ValueFailure.invalidEmail({
    required T failedValue,
  }) {
    return InvalidEmail<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.invalidPhoneNumber({
    required T failedValue,
  }) {
    return InvalidPhoneNumber<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.shortPassword({
    required T failedValue,
  }) {
    return ShortPassword<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.specialCharacterLetterNotIncluded({
    required T failedValue,
  }) {
    return SpecialCharacterAndNumber<T>(
      failedValue: failedValue,
    );
  }

  factory ValueFailure.passwordDoNotMatch({
    required T failedValue,
  }) {
    return PasswordDoNotMatch<T>(
      failedValue: failedValue,
    );
  }
}

class ExceedingLength<T> extends ValueFailure<T> {
  ExceedingLength({
    required this.failedValue,
    required this.max,
  });
  final T failedValue;
  final int max;
}

class Empty<T> extends ValueFailure<T> {
  Empty({
    required this.failedValue,
  });
  final T failedValue;
}

class Multiline<T> extends ValueFailure<T> {
  Multiline({
    required this.failedValue,
  });
  final T failedValue;
}

class ListTooLong<T> extends ValueFailure<T> {
  ListTooLong({
    required this.failedValue,
    required this.max,
  });
  final T failedValue;
  final int max;
}

class InvalidEmail<T> extends ValueFailure<T> {
  InvalidEmail({
    required this.failedValue,
  });
  final T failedValue;
}

class InvalidPhoneNumber<T> extends ValueFailure<T> {
  InvalidPhoneNumber({
    required this.failedValue,
  });
  final T failedValue;
}

class FirstName<T> extends ValueFailure<T> {
  FirstName({
    required this.failedValue,
  });
  final T failedValue;
}

class ShortPassword<T> extends ValueFailure<T> {
  ShortPassword({
    required this.failedValue,
  });
  final T failedValue;
}

class SpecialCharacterAndNumber<T> extends ValueFailure<T> {
  SpecialCharacterAndNumber({
    required this.failedValue,
  });
  final T failedValue;
}

class PasswordDoNotMatch<T> extends ValueFailure<T> {
  PasswordDoNotMatch({
    required this.failedValue,
  });
  final T failedValue;
}
