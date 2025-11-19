import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AbottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AbottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex, // correct property
      backgroundColor: Colors.transparent,
      color: Colors.blue.shade800,
      buttonBackgroundColor: Colors.blue.shade800,
      animationDuration: const Duration(milliseconds: 500),
      items: const [
        Icon(Icons.home_outlined, size: 30, color: Colors.white),
        Icon(Icons.search_rounded, size: 30, color: Colors.white),
        Icon(Icons.upload_rounded, size: 30, color: Colors.white),
        Icon(Icons.developer_mode, size: 30, color: Colors.white),
      ],
      onTap: onTap,
    );
  }
}
