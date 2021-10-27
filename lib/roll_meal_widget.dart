import 'dart:ui';

import "package:flutter/material.dart";
import "droppable_widget.dart";
import "dart:math";
import "vars.dart";

class rollMealWidgetState extends StatefulWidget {
  const rollMealWidgetState({Key? key}) : super(key: key);

  @override
  _rollMealWidgetStateState createState() => _rollMealWidgetStateState();
}

class _rollMealWidgetStateState extends State<rollMealWidgetState>
    with SingleTickerProviderStateMixin {
  _aboutEatWhatWidget(int imgNum, String name, String addr, String price) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(50),
      child: Column(
        children: [
          Image.asset(
            "images/$imgNum.jpg",
            height: 200,
            width: 400,
            fit: BoxFit.fitHeight,
          ),
          const Text(
            "今日宜恰",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 35,
              fontStyle: FontStyle.normal,
            ),
          ),
          Column(
            children: [
              Text(
                addr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic
                ),
              ),
              Text(
                price,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _nullWhatToEat() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(50),
      child: Column(
          children: [
            const Text(
              "今日无饭可恰",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              thickness: 3,
            ),
            const Text(
              "恰空气（CO2+H2O->淀粉）",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Column(
              children: const [
                Text(
                  "哪都能恰到",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "不要钱",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  _rolledWhatToEat() {
    List _whatToEatIndex = <int>[];
    var rand = Random();
    for (int i = 0;
        i < (thingsToEatList.length > 3 ? 3 : thingsToEatList.length);
        i++) {
      int temp;
      do {
        // get what to eat
        temp = rand.nextInt(thingsToEatList.length);
      } while (_whatToEatIndex.contains(temp));
      _whatToEatIndex.add(temp);
    }
    List _whatToEat = <Widget>[];
    for (var i in _whatToEatIndex) {
      _whatToEat.add(
        _aboutEatWhatWidget(
            _whatToEatIndex.indexOf(i) + 1,
            thingsToEatList[i].name,
            thingsToEatList[i].addr,
            thingsToEatList[i].price),
      );
    }
    _whatToEat.add(_nullWhatToEat());
    return _whatToEat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("恰啥"),
      ),
      body: DroppableWidget(
        children: _rolledWhatToEat(),
      ),
    );
  }
}
