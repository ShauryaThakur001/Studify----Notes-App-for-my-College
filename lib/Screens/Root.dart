import 'package:flutter/material.dart';
import 'package:studify/Screens/DeveloperScreen.dart';
import 'package:studify/Screens/HomeScreen.dart';
import 'package:studify/Screens/SearchScreen.dart';
import 'package:studify/Screens/UploadScreen.dart';
import 'package:studify/Widgets/BottomNavBar.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  int index=0;

  final List<Widget>_pages=[
    HomePage(),
    SearchPage(),
    UploadPage(),
    DeveloperPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // keeps curved bar floating
      body: _pages[index],
      bottomNavigationBar: AbottomBar(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
    );
  }
}