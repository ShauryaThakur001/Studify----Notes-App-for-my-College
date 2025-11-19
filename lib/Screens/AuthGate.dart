import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studify/Screens/LoginScreen.dart';
import 'package:studify/Screens/Root.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // Checking the auth state (loading)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // User is logged in
        if (snapshot.hasData) {
          return const Root();
        }

        // User is NOT logged in
        return const LoginPage();
      },
    );
  }
}
