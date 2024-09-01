import 'package:flutter/material.dart';
import 'package:pradyek101/data/model/add_data.dart';
import 'package:pradyek101/screens/home.dart';
import 'package:pradyek101/screens/statistics.dart';
import 'package:pradyek101/widgets/bottomNavBar.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddDataAdapter());
  await Hive.openBox<AddData>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BotNavBar(),
    );
  }
}