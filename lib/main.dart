import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dictionary.dart';
import "string_extension.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Password Generator'),
      supportedLocales: const [
        Locale('en', ''),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _generated = false;
  String randomPassword = '';

  @override
  initState() {
    super.initState();
    if (_generated == false){
      generate();
    }
  }

  void generate(){
    Random random = Random();

    int randomNumber = random.nextInt(999);
    bool first = random.nextDouble() <= 0.7;

    String str1 = adjectives[random.nextInt(adjectives.length)];
    String str2 = nouns[random.nextInt(nouns.length)];

    String randomStr1 = str1.capitalize();
    String randomStr2 = str2.capitalize();

    randomPassword = first ? '$randomNumber$randomStr1$randomStr2': '$randomStr1$randomStr2$randomNumber';
  }

  void _generatePassword() {
    setState(() {
      _generated = true;
      generate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Center(
                child: GestureDetector(
                  onTap: () => Clipboard.setData(ClipboardData(text: randomPassword)).then((_){
                    Fluttertoast.showToast(msg: 'Copied to clipboard');
                  }),
                  child: Text(
                    randomPassword,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 80.0,
        width: 80.0,
        child: FloatingActionButton(
          onPressed: _generatePassword,
          tooltip: 'Generate new password',
          child: const Icon(Icons.refresh, size: 50,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

