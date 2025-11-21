
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  DeveloperPage({super.key});

  // Profile Image Path (your uploaded file)
  final String profileImagePath =
      '/mnt/data/A_digital_business_card_features_Shaurya_Thakur,_a.png';

  // URL Launcher
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print("Could not launch $url");
    }
  }

  // Social Icon Button
  Widget _socialButton(IconData icon, String url) {
    return InkWell(
      onTap: () => openLink(url),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade800.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: FaIcon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // simple white background

      body: Center(
        child: Container(
          width: 330,
          height: 560,

          // Gradient border + soft shadow
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade400,
                Colors.blue.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // reduced shadow
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              color: Colors.white.withOpacity(0.97),
              child: Stack(
                children: [
                  // Inner blur for slight glass effect
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),

                  // CONTENT
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),

                        // Profile Avatar
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade300,
                                Colors.blue.shade700,
                              ],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: Colors.white,
                            child: ClipOval(child: _buildProfileImage()),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Name
                        Text(
                          "Shaurya Thakur",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Role
                        Text(
                          "Developer",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue.shade600,
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Divider bar
                        Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade300,
                                Colors.blue.shade600,
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Short bio
                        Text(
                          "Passionate Flutter Developer building Studify — "
                          "a notes & question paper sharing app for students.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.4,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const Spacer(),

                        // Gmail Contact Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              openLink("mailto:shaurya3537@gmail.com");
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.blue.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 6,
                            ),
                            child: const Text(
                              "Contact",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Social Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _socialButton(FontAwesomeIcons.github,
                                "https://github.com/Shaurya0987"),
                            _socialButton(FontAwesomeIcons.linkedin,
                                "https://www.linkedin.com/in/shauryathakur001/"),
                            _socialButton(FontAwesomeIcons.instagram,
                                "https://instagram.com/sherry_18__/"),
                          ],
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


Widget _buildProfileImage() {
  return Image.asset(
    'assets/profile.jpeg',
    fit: BoxFit.cover,
    width: 110,
    height: 110,
  );
}
}