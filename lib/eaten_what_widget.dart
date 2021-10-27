import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import "edit_data.dart";
import "vars.dart";

class eatenWhatWidget extends StatefulWidget {
  const eatenWhatWidget({Key? key}) : super(key: key);

  @override
  _eatenWhatWidgetState createState() => _eatenWhatWidgetState();
}

class _eatenWhatWidgetState extends State<eatenWhatWidget> {
  Widget _buildWhatToEatRow(int id, String name, String addr, String price) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Row(
        children: [
          // the column of name and address is longer
          Expanded(
              child: Column(
            // left align
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                addr,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: thingsToEatList.length,
      itemBuilder: (context, i) {
        var id = thingsToEatList[i].id;
        var name = thingsToEatList[i].name;
        var addr = thingsToEatList[i].addr;
        var price = thingsToEatList[i].price;
        return Slidable(
          child: Column(
            children: [
              _buildWhatToEatRow(id, name, addr, price),
            ],
          ),
          actionPane: const SlidableScrollActionPane(),
          secondaryActions: [
            IconSlideAction(
              caption: "不想恰",
              color: Colors.red,
              icon: Icons.delete,
              closeOnTap: true,
              onTap: () {
                thingsToEatList.removeAt(i);
                setState(() { });
                dumpThingToEatList();
              },
            ),
            IconSlideAction(
              caption: "编辑",
              color: Colors.orange,
              icon: Icons.edit,
              closeOnTap: true,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return editData(index: i);
                    }
                )).then((value){
                  setState(() {

                  });
                });
                ;
              },
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1.0, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }
}
