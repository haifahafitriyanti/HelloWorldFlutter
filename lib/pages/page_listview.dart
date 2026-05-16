import 'package:flutter/material.dart';

class PageListview extends StatelessWidget {
  const PageListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Page List View"),
      ),

      body: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.green,
          ),
          SizedBox(height: 10,), //spasi kalau ke bawah vertikal
          Container(
            width: 100,
            height: 100,
            color: Colors.pink,
          ),
          SizedBox(height: 10,),
          Container(
            width: 100,
            height: 100,
            color: Colors.purple,
          ),
          SizedBox(height: 10,),
          Container(
            width: 100,
            height: 100,
            color: Colors.yellow,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
