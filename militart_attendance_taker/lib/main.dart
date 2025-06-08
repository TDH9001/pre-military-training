import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_reader/scanner_page.dart';
import 'package:qr_reader/student_info_caching_service.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await StudentInfoCachingService.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تسجيل الحضور و الانصراف للتربيه العسكريه',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      routes: {'/': (context) => QRScannerPage()},
      initialRoute: '/',
    );
  }
}
