import 'package:flutter/material.dart';

class Album extends StatelessWidget {
  const Album({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Image.asset(
            "",
            height: 200,
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(this.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              textBaseline: TextBaseline.alphabetic)),
                      ElevatedButton.icon(
                        onPressed: () {
                          print(this.title);
                        },
                        icon: Icon(Icons.add_shopping_cart),
                        label: Text("Add to cart"),
                      )
                    ],
                  )))
        ]));
  }
}
