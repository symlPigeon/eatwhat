import 'package:flutter/material.dart';
import "dart:io";
import "package:path_provider/path_provider.dart";

class thingsToEat {
  late final int id;
  late final String name;
  late final String addr;
  late final String price;

  thingsToEat(this.id, this.name, this.addr, this.price);
}

// TODO : using a database, loading this list from database on start
var thingsToEatList = <thingsToEat>[];
var entries = 0;
//  thingsToEat(1, "川锦汇麻辣拌", "老综二楼北侧", "20-30元"),
//   thingsToEat(2, "章鱼小丸子", "新综过道北侧楼梯下", "8-10元"),
//   thingsToEat(3, "三顾冒菜", "老综一楼", "20-30元"),
//   thingsToEat(4, "蜜雪冰城", "新综或者老综", "4-10元"),
//   thingsToEat(5, "鸭腿饭", "竹园餐厅", "10-15元"),
//   thingsToEat(6, "瓦香鸡", "丁香餐厅二楼", "10-15元"),
//   thingsToEat(7, "酸奶大麻花", "丁香食堂一楼", "5元"),

Future<void> createInitialCSV() async{
  String dir = (await getApplicationDocumentsDirectory()).path;
  var file = File("$dir/eatwhat.csv");
  try {
    await file.writeAsString("");
    // default CSV data
    final listTemp = <thingsToEat>[
      thingsToEat(1, "川锦汇麻辣拌", "老综二楼北侧", "20-30元"),
      thingsToEat(2, "章鱼小丸子", "新综过道北侧楼梯下", "8-10元"),
      thingsToEat(3, "三顾冒菜", "老综一楼", "20-30元"),
      thingsToEat(4, "蜜雪冰城", "新综或者老综", "4-10元"),
      thingsToEat(5, "鸭腿饭", "竹园餐厅", "10-15元"),
      thingsToEat(6, "瓦香鸡", "丁香餐厅二楼", "10-15元"),
      thingsToEat(7, "酸奶大麻花", "丁香食堂一楼", "5元"),
    ];
    for (thingsToEat infTuple in listTemp) {
      String s =
          "${infTuple.name},${infTuple.addr},${infTuple.price}\n";
      await file.writeAsString(s, mode: FileMode.append);
    }
  } on FileSystemException {
    rethrow;
  }
}

Future<void> initThingToEatList() async {
  final dir = (await getApplicationDocumentsDirectory()).path;
  final file = File("$dir/eatwhat.csv");
  if (!await file.exists()){
    await file.create();
    await createInitialCSV();
  }
  try {
    String contents = await file.readAsString();
    List<String> dataList = contents.split('\n');
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].isNotEmpty) {
        List<String> tuple = dataList[i].split(',');
        thingsToEatList.add(
          thingsToEat(
            i,
            tuple[0],
            tuple[1],
            tuple[2],
          ),
        );
      }
    }
    entries = dataList.length - 1;
  } on FileSystemException {
    rethrow;
  }
}

Future<void> dumpThingToEatList() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  var file = File("$dir/eatwhat.csv");
  try {
    await file.writeAsString("");
    for (thingsToEat infTuple in thingsToEatList) {
      String s =
          "${infTuple.name},${infTuple.addr},${infTuple.price}\n";
      await file.writeAsString(s, mode: FileMode.append);
    }
  } on FileSystemException {
    rethrow;
  }
}
