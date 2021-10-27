import 'package:eat_what/eaten_what_widget.dart';
import "package:flutter/material.dart";
import "vars.dart";

class insertNewData extends StatefulWidget {
  const insertNewData({Key? key}) : super(key: key);

  @override
  _insertNewDataState createState() => _insertNewDataState();
}

class _insertNewDataState extends State<insertNewData> {
  final TextEditingController _whatEatController = TextEditingController();
  final TextEditingController _whereEatController = TextEditingController();
  final TextEditingController _howMuchEatController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("想恰啥"),
      ),
      body: Container(
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              const Text(
                "今天想恰什么捏",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                textAlign: TextAlign.left,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _whatEatController,
                decoration: const InputDecoration(
                  labelText: "有啥店可以恰",
                  hintText: "西冰库大酒店",
                  prefixIcon: Icon(Icons.local_dining),
                ),
                validator: (v) {
                  for (var i in thingsToEatList) {
                    if (v!.trim() == i.name) {
                      return "私密马赛，已经有人想恰了（鞠躬）。";
                    }
                  }
                  if ((v!.trim().isNotEmpty) && (v.trim().length < 16)) {
                    return null;
                  } else {
                    return "私密马赛，您输入的不合法（鞠躬）。";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _whereEatController,
                decoration: const InputDecoration(
                  labelText: "去哪里可以恰到",
                  hintText: "首尔龙山区西冰库洞",
                  prefixIcon: Icon(Icons.home_outlined),
                ),
                validator: (v) {
                  if ((v!.trim().isNotEmpty) && (v.trim().length < 16)) {
                    return null;
                  } else {
                    return "私密马赛，您输入的不合法（鞠躬）。";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _howMuchEatController,
                decoration: const InputDecoration(
                  labelText: "恰一顿要多少钱",
                  hintText: "114514~1919810円",
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                validator: (v) {
                  if ((v!.trim().isNotEmpty) && (v.trim().length < 16)) {
                    return null;
                  } else {
                    return "私密马赛，您输入的不合法（鞠躬）。";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                          child: Text("确定～"),
                        ),
                        onPressed: () {
                          if ((_formKey.currentState as FormState).validate()) {
                            var name = _whatEatController.text;
                            var addr = _whereEatController.text;
                            var price = _howMuchEatController.text;
                            entries++;
                            setState(() {
                              thingsToEatList
                                  .add(thingsToEat(entries, name, addr, price));
                            });
                            try {
                              dumpThingToEatList();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: const Text(
                                        '200 OK',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          child: const Text(
                                            'ACK',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: const Text("私密马赛，出错了(鞠躬)"),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () =>
                                              Navigator.of(context).pop,
                                          child: const Text("OK"),
                                        )
                                      ],
                                    );
                                  });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
