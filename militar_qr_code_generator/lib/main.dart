import 'package:flutter/material.dart';
import 'package:militar_qr_code_generator/form_screen.dart';
import 'package:militar_qr_code_generator/introduction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تسجيل دوره التربيه العسكريه',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      routes: {
        '/': (context) => const IntroductionPage(),
        '/form': (context) => FormFillScreen(),
      },
      initialRoute: '/',
    );
  }
}
