import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'dart:async';

import 'func.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChoosingPage(),
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

class AuthorizationTelegram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация Telegram'),
      ),
      body:Stack(
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
  String data_ex = '';
  TextEditingController loginController = TextEditingController();

  Future<void> sendDataToServer(String login) async {
    var url = 'http://127.0.0.1:5000/tg?Number=' + login;
    await Future.delayed(Duration.zero, () {
      getServer(url);
    });
    setState(() {
      data_ex = login;
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
            child: TextField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: 'Введите логин VK',
              ),
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
                await sendDataToServer(loginController.text);
              },
              child: Text('Ввод'),
            ),
          ),
          Positioned(
            top: 100,
            child: Center(
              child: Text(data_ex, style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}