import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/app_config/app_config_repository.dart' show AppConfigRepository;
import '../../src/domain/itinerary/request/mood.dart';

part 'app_mode_state.dart';

class AppModeCubit extends Cubit<AppModeState> {
  final AppConfigRepository appConfigRepository;
  List<Mood> _appModes = [];  // 🔥 Private variable to keep data alive.

  AppModeCubit({required this.appConfigRepository}) : super(AppModeInitial());

  Future<void> loadAppModes() async {
    emit(AppModeLoading());

    final result = await appConfigRepository.loadAppModes();

    result.fold(
          (error) => emit(AppModeError(message: error.toString())),
          (appModes) {
        _appModes = appModes;  // 🔥 Save data for later use.
        emit(AppModeLoaded(appModes: appModes));
      },
    );
  }

  /// ✅ Getter to access the saved modes from other screens.
  List<Mood> get appModes => _appModes;
}
