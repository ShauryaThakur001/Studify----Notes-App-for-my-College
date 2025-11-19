import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studify/Screens/FireBase_Auth_Service.dart';
import 'package:studify/Screens/Root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final googleAuth = GoogleAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              const SizedBox(height: 120),

              // LOGO
              Icon(
                Icons.school,
                color: Colors.blue.shade800,
                size: 200,
              ),

              const SizedBox(height: 10),

              // APP NAME
              Text(
                "Studify",
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.blue.shade800,
                  fontFamily: "Inspiration",
                ),
              ),

              const Spacer(),

              // GOOGLE SIGN-IN BUTTON (with FaIcon)
              GestureDetector(
                onTap: () async {
                  try {
                    final user = await googleAuth.signInWithGoogle();

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Root()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Google Login cancelled")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
                child: Container(
                  height: 55,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 80),

              Text(
                "An investment in knowledge pays the best interest.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
