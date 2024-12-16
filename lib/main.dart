import 'package:flutter/material.dart';
import 'views/dog_view.dart';

void main() {
  runApp(DogApp());
}

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog CRUD API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DogView(),
    );
  }
}
