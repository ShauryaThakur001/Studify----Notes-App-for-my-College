import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studify/Screens/HomeScreen.dart';
import 'package:studify/Screens/LoginScreen.dart';
import 'package:studify/Screens/SplashScreen.dart';
import 'package:studify/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Studify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800)
      ),
      home: SplashScreen(),
    );
  }

}