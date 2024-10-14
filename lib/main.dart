import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/user/presentation/login/providers/login_token_provider.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/core/services/notification/notification_service.dart';
import 'src/core/services/storage/storage_service.dart';
import 'src/core/utils/provider_logger.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await StorageService.init();
  await NotificationService.init();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(loginTokenNotifierProvider.future).then((_) {
            FlutterNativeSplash.remove();
          });
          return App();
        },
      ),
    ),
  );
}
