import 'dart:async'; // Імпортуємо для використання Timer
import 'package:flutter/material.dart';
import 'package:massage_simulator/data/datasources/massage_control_screen.dart';
import 'package:massage_simulator/presentation/screens/last_payment_screen.dart'; // Імпортуємо екран останніх оплат

class Payment {
  final double amount;
  final String date;

  Payment({required this.amount, required this.date});
}

class MassageControlScreen extends StatefulWidget {
  final Payment payment; // Отримуємо оплату як параметр

  const MassageControlScreen({super.key, required this.payment});

  @override
  MassageControlScreenState createState() => MassageControlScreenState();
}

class MassageControlScreenState extends State<MassageControlScreen> {
  bool _isRunning = false;
  late Timer _timer; // Оголошуємо таймер
  int _secondsRemaining = 30; // Стартовий час (наприклад 30 секунд)
  late MassageControlController mc;
  @override
  void initState() {
    super.initState();
    mc = MassageControlController(); // Initialize mc here
  }

  void _startMassage() {
    setState(() {
      _isRunning = true;
    });

    // Запускаємо таймер з інтервалом 1 секунда
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _stopMassage(); // Зупиняємо масаж, коли час закінчився
        }
      });
    });

    // Виконання HTTP запиту при старті масажу
    mc.sendHttpRequest();
  }

  void _stopMassage() {
    setState(() {
      _isRunning = false;
      _timer.cancel(); // Зупиняємо таймер
    });

    // Виконання HTTP запиту при зупинці масажу
    mc.sendHttpRequest();
  }

  @override
  void dispose() {
    _timer.cancel(); // Очищаємо таймер при виході з екрану
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Керування масажером',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange, // Встановлюємо колір AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Відступи для контенту
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Зображення або піктограма для масажера
              Icon(
                Icons.accessibility_new,
                size: 100,
                color: Colors.orange,
              ),
              SizedBox(height: 20),
              // Виведення часу залишку
              Text(
                'Час: $_secondsRemaining секунд',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 40),
              // Кнопка старту масажу
              ElevatedButton(
                onPressed: _isRunning ? null : _startMassage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRunning ? Colors.red : Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Старт масажу',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Кнопка зупинки масажу
              ElevatedButton(
                onPressed: !_isRunning ? null : _stopMassage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_isRunning ? Colors.red : Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Стоп масажу',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Перехід на екран останніх оплат
              TextButton(
                onPressed: () {
                  // Перехід на LastPaymentScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LastPaymentScreen(payment: widget.payment),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green, // Зелений колір для тексту
                ),
                child: Text(
                  'Переглянути останні оплати',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
