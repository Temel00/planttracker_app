import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/auth/secrets.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

final dio = Dio();
String url = 'https://perenual.com/api/species-list?key=$plantKey&indoor=1';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Title')),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                devtools.log('Button Pressed');
              },
              child: const Text("Grab Indoor Plants"),
            )
          ],
        ));
  }
}
