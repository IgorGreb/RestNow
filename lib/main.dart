import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:massage_simulator/presentation/screens/payment_screen.dart';

void main() {
  _setupLogging(); // Налаштування логування
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // Встановлюємо рівень логування
  Logger.root.onRecord.listen((record) {
    // Логуємо кожне повідомлення
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
}

class MyApp extends StatelessWidget {
  final Logger _logger = Logger('MyApp'); // Створюємо логгер для цього класу

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _logger.info('App is starting...'); // Логуємо старт додатку

    return MaterialApp(
      title: 'Massage Simulator',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.orange,
        ),
      ),
      home: PaymentScreen(),
    );
  }
}
