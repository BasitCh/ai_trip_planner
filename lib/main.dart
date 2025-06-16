import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_hero/firebase_options.dart';
import 'package:travel_hero/global/services/firebase_messaging_service.dart';
import 'package:travel_hero/src/infrastructure/di/injectable.dart';
import 'package:widgets_book/widgets_book.dart';
import 'app_bloc_observer.dart';
import 'travel_hero_app.dart';

Future<void> main() async {
  _setDeviceOrientation();
  await _initFirebase();
  initiateFireBase();
  Bloc.observer = AppBlocObserver();
  await registerServices();
  await dotenv.load(fileName: ".env");
  runApp(DevicePreview(
      // enabled: true, // enable disable to preview on multiple devices.
      enabled: false,
      builder: (context) => const ScreenUtilSetup(child: TravelHeroApp())));
  // runApp(const ScreenUtilSetup(child: IgmuApp()));
}
initiateFireBase() {
  final messagingService = FirebaseMessagingService(
  );
  messagingService.init();
}
void _setDeviceOrientation() {
  /// Set device orientation to portrait
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

Future<void> _initFirebase() async {
  /// Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

}
