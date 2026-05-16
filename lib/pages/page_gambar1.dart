import 'package:flutter/material.dart';

class PageGambar1 extends StatelessWidget {
  const PageGambar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rumah Gadang"),
        backgroundColor: Colors.brown,
      ),
      
      body: Center(
        child: Image.asset("images/rumah.jpg"),
      ),
    );
  }
}
