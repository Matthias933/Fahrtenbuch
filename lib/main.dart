import 'package:fahrtenbuch/entities/ride.dart';
import 'package:fahrtenbuch/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(RideAdapter());

  var box = await Hive.openBox('myBox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
