import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'func.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // Задаем LoginPage() как стартовую страницу
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Здесь может быть логика проверки авторизации

    // При успешной авторизации переходим на следующую страницу
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChoosingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Center(
          child: Text('Авторизация в приложении "Common massagers"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
        ) 
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Имя пользователя',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Пароль',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoosingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Вход',
              style: TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
        ) 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon:  Image.asset('assets/images/telegram.png', width: 80, height: 80),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationTelegram()));
                      },
                    ),
                    const Text('Telegram',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon:  Image.asset('assets/images/VK.png', width: 90, height: 90),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationVK()));
                      },
                    ),
                    const Text('VK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorizationTelegram extends StatefulWidget {
  @override
  _AuthorizationTelegramState createState() => _AuthorizationTelegramState();
}

class _AuthorizationTelegramState extends State<AuthorizationTelegram> {
  final TextEditingController _numberController = TextEditingController();

  Future<void> _sendNumberToServer() async {
    final String number = _numberController.text;
    final Uri url = Uri.parse('http://127.0.0.1:5000/tg?Number=$number');
    try {
      final response = await http.get(url); // Выполняем GET запрос
      if (response.statusCode == 200) {
        // Обработка успешного запроса
        print('Number sent successfully: ${response.body}');
      } else {
        // Обработка ошибки
        print('Failed to send number');
      }
    } catch (e) {
      print('Error sending number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация Telegram'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingPage()));
              },
              child: Text('Вернуться'),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationVK()));
              },
              child: Text('Авторизация VK'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'Введите номер телефона',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendNumberToServer,
                  child: Text('Отправить'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorizationVK extends StatefulWidget {
  @override
  _AuthorizationVKState createState() => _AuthorizationVKState();
}

class _AuthorizationVKState extends State<AuthorizationVK> {
  String loginData = '';
  String passwordData = '';
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> sendDataToServer(String login, String password) async {
    var url = 'http://127.0.0.1:5000/vk/signup?Number=' + login + '&Password=' + password;
    await Future.delayed(Duration.zero, () {
      getServer(url);
    });
    setState(() {
      loginData = login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация VK'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: loginController,
                  decoration: InputDecoration(
                    hintText: 'Введите логин VK',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Введите пароль VK',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingPage()));
              },
              child: Text('Вернуться'),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorizationTelegram()));
              },
              child: Text('Авторизация Telegram'),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                await sendDataToServer(loginController.text, passwordController.text);
              },
              child: Text('Ввод'),
            ),
          ),
          Positioned(
            top: 100,
            child: Center(
              child: Text(loginData, style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}