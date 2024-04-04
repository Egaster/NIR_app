import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PageOne()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo()));
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

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page One'),
      ),
      body: Center(
        child: Text('This is Page One'),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Two'),
      ),
      body: Center(
        child: Text('This is Page Two'),
      ),
    );
  }
}