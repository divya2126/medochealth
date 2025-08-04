import 'package:flutter/material.dart';

class MyBuffer extends StatelessWidget {
  const MyBuffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buffer"),
      ),
      body: Container(
        height: 100,
        width: 600,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text("I need to go home"),
            ],
          ),
        ),
      ),
    );
  }
}