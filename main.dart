import 'package:flutter/material.dart';
import 'login.dart';
import 'items.dart';
import 'cart.dart';
import 'item.dart';
import 'addCategory.dart';
import 'addItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}