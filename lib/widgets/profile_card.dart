import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final cardWidth = isPortrait ? size.width * 0.9 : size.width * 0.7;
    final fontSize = size.width < 600 ? 14.0 : 16.0;

    return Container(
      width: cardWidth.clamp(200, 400), // Min 200px, max 400px
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
          Text(email, style: TextStyle(fontSize: fontSize - 2, color: Colors.grey)),
        ],
      ),
    );
  }
}