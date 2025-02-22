import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:massage_simulator/presentation/screens/massage_control_screen.dart';

class LastPaymentScreen extends StatelessWidget {
  final Payment payment; // Отримуємо передану оплату через конструктор

  const LastPaymentScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    // Форматуємо дату без секунд і мілісекунд
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(payment.date));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Остання Оплата',
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
              // Зображення або піктограма для оплати
              Icon(
                Icons.payment,
                size: 100,
                color: Colors.orange,
              ),
              SizedBox(height: 40),
              // Виведення суми та дати
              Text(
                'Сума: ${payment.amount} грн',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                'Дата: $formattedDate', // Використовуємо відформатовану дату
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
              SizedBox(height: 40),
              // Кнопка для повернення на екран масажу або інший екран
            ],
          ),
        ),
      ),
    );
  }
}
