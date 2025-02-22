import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MassageControlController {
  bool isRunning = false;
  int secondsRemaining = 30;

  // Функція для відправки HTTP запиту
  Future<void> sendHttpRequest() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.post(
        url,
        body: {
          'title': 'Massage Control',
          'body': 'Started or stopped the massage.'
        },
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Запит успішно виконано! Ресурс створено.${response.body}');
        }
      } else {
        if (kDebugMode) {
          print('Помилка запиту: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Помилка при виконанні запиту: $e');
      }
    }
  }
}
