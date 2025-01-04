import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/provider/health_metrics_provider.dart';
import 'package:health_journal/provider/journal_provider.dart';
import 'package:health_journal/provider/message_provider.dart';
import 'package:health_journal/splash/view/splash.dart';
import 'package:health_journal/utils/colors.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(
     // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  );
  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);
  await Hive.openBox('journal');
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  runApp(MyApp(
    hasSeenOnboarding: hasSeenOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JournalProvider>(
          create: (_) => JournalProvider(),
        ),
        ChangeNotifierProvider<HealthProvider>(
          create: (_) => HealthProvider()..fetchHealthData(),
        ),

        ChangeNotifierProvider<MessageProvider>(
          create: (_) => MessageProvider()..fetchMessage(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.defaultBlue),
                useMaterial3: true,
              ),
              home: const SplashScreen()
          );
        },
      ),
    );
  }

}