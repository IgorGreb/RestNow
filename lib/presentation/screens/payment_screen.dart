import 'package:flutter/material.dart';
import 'package:massage_simulator/presentation/screens/massage_control_screen.dart'; // Імпортуємо екран для керування масажем

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  bool isProcessing = false;
  List<Payment> payments = []; // Список для збереження оплат в пам'яті

  Future<void> simulatePayment() async {
    setState(() {
      isProcessing = true; // Показуємо індикатор завантаження
    });

    // Імітація затримки для обробки платежу
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isProcessing = false; // Сховаємо індикатор після завершення
    });

    // Створення нового об'єкта оплати
    final payment = Payment(
      amount: 100.0, // Приклад суми
      date: DateTime.now().toString(), // Поточна дата та час
    );

    // Додаємо оплату до списку
    setState(() {
      payments.add(payment);
    });

    // Показуємо повідомлення про успішну оплату
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Оплачено')),
    );

    // Переходимо на екран керування масажем після успішної оплати
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MassageControlScreen(
            payment: payment), // Передаємо оплату на екран MassageControlScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Оплата',
          style: TextStyle(color: Colors.black),
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
              // Іконка для оплати
              Icon(
                Icons.payment,
                size: 100,
                color: Colors.orange,
              ),
              SizedBox(height: 40),
              // Кнопка для симуляції платежу
              isProcessing
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orange), // Встановлюємо колір індикатора
                    ) // Показуємо індикатор, якщо обробляємо
                  : ElevatedButton(
                      onPressed:
                          simulatePayment, // Запускаємо платіж при натисканні
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Колір кнопки
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Оплатити',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
