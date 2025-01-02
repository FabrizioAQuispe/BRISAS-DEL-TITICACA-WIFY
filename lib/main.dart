import 'package:brisasdeltiticaca/screens/camera-screen.dart';
import 'package:flutter/material.dart';
  
void main() {
  runApp(const MainApp());
}                             

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brisas del Titicaca Wifi',
      theme: ThemeData(

      ),

      home: CameraWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}