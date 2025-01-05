import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_journal/history/view/history.dart';
import 'package:health_journal/journalling/view/journaling.dart';
import 'package:health_journal/splash/view/splash.dart';
import 'package:health_journal/splash/view/splash_three.dart';
import 'package:health_journal/splash/view/splash_two.dart';

import '../dashboard/view/home_page.dart';
import '../onboarding/view/onboarding.dart';

class RouteManager {
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String journaling = '/journaling';
  static const String history = '/history';
  static const String splash = '/splash';
  static const String splashTwo = '/splashTwo';
  static const String splashThree = '/splashThree';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => HomePage());
      case journaling:
        return MaterialPageRoute(builder: (_) => JournalingScreen());
      case history:
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case splashTwo:
        return MaterialPageRoute(builder: (_) => SplashScreenTwo());
      case splashThree:
        return MaterialPageRoute(builder: (_) => SplashScreenThree());
      default:

        return null;
    }
  }
}
