import 'package:flutter/material.dart';
import 'package:compass_maps_app/advanced_map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Maps Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdvancedMapScreen(),
    );
  }
}
