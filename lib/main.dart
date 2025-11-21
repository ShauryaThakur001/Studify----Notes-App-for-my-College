import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studify/Screens/DeveloperScreen.dart';
import 'package:studify/Screens/HomeScreen.dart';
import 'package:studify/Screens/LoginScreen.dart';
import 'package:studify/Screens/Root.dart';
import 'package:studify/Screens/SplashScreen.dart';
import 'package:studify/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: 'https://bxhkhtyxahvubcblwskz.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4aGtodHl4YWh2dWJjYmx3c2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1OTk3NDUsImV4cCI6MjA3OTE3NTc0NX0.dTufBDZMKrZt0I8Od9YHKueZ2YKY9h4WFRGSC2q4Lys'
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
      ),
      home: SplashScreen(),
    );
  }
}
