import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const StudyBuddy());
}

class StudyBuddy extends StatelessWidget {
  const StudyBuddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Buddy',
      theme: getAppTheme(),
      home: SplashScreen(),
    );
  }
}
