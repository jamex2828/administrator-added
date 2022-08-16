import 'package:flutter/material.dart';

void main() {
  runApp(Users());
}

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CL1M Inventory'),
        ),
        body: const Center(
          child: Text('User List'),
        ),
      ),
    );
  }
}