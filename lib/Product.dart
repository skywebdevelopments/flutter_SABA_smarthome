import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product(
      {Key? key,
      required this.name,
      required this.desc,
      required this.price,
      required this.image})
      : super(key: key);
  final String name;
  final String desc;
  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Image.network(
            this.image,
            height: 150,
            width: 150,
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(this.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              textBaseline: TextBaseline.alphabetic)),
                      Text("Price: ${this.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text("${this.desc}"),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text("Add to cart"),
                      )
                    ],
                  )))
        ]));
  }
}
