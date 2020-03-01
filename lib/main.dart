import 'package:flutter/material.dart';
import 'package:so/src/global/provider.dart';
import 'package:so/src/pages/home_page.dart';
import 'package:so/src/pages/processes_page.dart';
import 'package:so/src/pages/result_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (BuildContext context) => HomePage(),
          'processes': (BuildContext context) => ProcessesPage(),
          'result': (BuildContext context) => ResultPage(),
        },
        initialRoute: 'home',
      ),
    );
  }
}
