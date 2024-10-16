import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:orient/common_modules_widgets/request_card.widget.dart';
import 'package:orient/common_modules_widgets/template_page.widget.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/models/request.model.dart';
import 'package:orient/utils/animated_custom_dropdown/custom_dropdown.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'general_services/app_config.service.dart';
import 'general_services/conditional_imports/mock_file.dart'
    if (dart.library.js_util) 'general_services/conditional_imports/change_url_strategy.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'modules/main_screen/view_models/main_viewmodel.dart';
import 'platform/platform_is.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // register global error handlers to catch , handle and repoting on any kind of error or exception appear in the application
  /// [ENABLED] IN RELEASE ( DISABLE IN DEVELOPMENT TIME TO APPEAR ANY ERROR APPEAR )
  // registerErrorHandlers();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  // using pathUrl strategy for flutter web to change the default hash strategy of url and make url more clean and seem as native web url.
  if (!PlatformIs.android && !PlatformIs.iOS) {
    changeUrlStrategyService();
  }
  // gorouter configuration
  GoRouter.optionURLReflectsImperativeAPIs = true;
  try {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  } catch (ex, t) {
    debugPrint('Failed to initialize Hive Database $ex $t');
  }
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/json/lang',
      fallbackLocale: const Locale('en'),
      // Enable saving the selected locale in local storage
      saveLocale: true,
      child: MultiProvider(
        // inject all providers to make it accessable intire all application via context.
        providers: [
          ChangeNotifierProvider<AppConfigService>(
            create: (_) => AppConfigService(),
          ),
          ChangeNotifierProvider<MainScreenViewModel>(
            create: (_) => MainScreenViewModel(),
          ),
        ],
        child: const MyApp2(),
        // child: const MyApp(),
      )));
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestApp(),
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapH36,
              // PostWidget(),
              // gapH16,
              // PostWidget(),
              // gapH16,
              // PostWidget(),
              // gapH16,
              // PostWidget(),
              // gapH16,
              // PostWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
