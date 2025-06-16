import 'dart:async';

class TimerService {
  Stream<int> countdown({required int from}) {
    return Stream.periodic(const Duration(seconds: 1), (i) => from - i - 1)
        .take(from);
  }


}