import 'dart:async';

import "package:flutter/material.dart";
import 'eaten_what_widget.dart';
import "vars.dart";
import "roll_meal_widget.dart";
import "insert_data.dart";


class StartupPage extends StatefulWidget {
  StartupPage({Key? key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  late Timer timer;
  @override
  void initState() {
    startTimeout();
    super.initState();
  }

//设置跳转时间，时间过后执行回调函数
  startTimeout() {
    const timeout = Duration(seconds: 2); //跳转时间
    timer = Timer(timeout, handleTimeout);
  }

//回调函数，路由跳转界面
  handleTimeout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => mainPageWidget()),
          (route) => route == false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initThingToEatList();
    return const Scaffold(
      primary: true,
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          '都有啥恰的',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}


class mainPageWidget extends StatefulWidget {
  mainPageWidget({Key? key}) : super(key: key);

  @override
  _mainPageWidgetState createState() => _mainPageWidgetState();
}

class _mainPageWidgetState extends State<mainPageWidget> {
  late Widget _getNewEatWhat;
  void _pushRollMeal() {
    Navigator.of(this.context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const rollMealWidgetState();
      },
    ));
  }

  void _addNewMeal(){
    Navigator.of(this.context).push(MaterialPageRoute<void>(
        builder: (BuildContext context){
          return const insertNewData();
        }
      )
    ).then((value){
      setState(() { _getNewEatWhat = eatenWhatWidget(); });
    });
  }

  @override
  Widget build(BuildContext context) {
    thingsToEatList.shuffle();
    _getNewEatWhat = const eatenWhatWidget();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(
              child: Text("syml今天吃什么"),
            ),
            IconButton(
              onPressed: _pushRollMeal,
              icon: const Icon(Icons.fastfood),
            ),
          ],
        ),
      ),
      body: _getNewEatWhat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addNewMeal,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EAT What",
      home: StartupPage(),
    );
  }
}

main() {
  runApp(MyApp());
}
