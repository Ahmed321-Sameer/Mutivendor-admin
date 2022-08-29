import 'package:flutter/material.dart';

import 'AllProduct.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ManagePage',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blue[900],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            GestureDetector(onTap: () {}, child: myContainer('Users')),
            const Divider(),
            GestureDetector(onTap: () {}, child: myContainer('Sellers')),
            const Divider(),
            GestureDetector(onTap: () {}, child: myContainer('Categories')),
            const Divider(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => AllProducts()));
                },
                child: myContainer('All Products')),
            const Divider(),
            GestureDetector(onTap: () {}, child: myContainer('Orders'))
          ],
        ),
      ),
    );
  }
}

Widget myContainer(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        Icon(
          Icons.keyboard_double_arrow_right_rounded,
          size: 25,
          color: Colors.black,
        ),
      ],
    ),
  );
}
