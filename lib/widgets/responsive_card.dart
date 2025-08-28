import 'package:flutter/material.dart';

class ResponsiveCard extends StatelessWidget {
  final String title;

  const ResponsiveCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final cardWidth = isPortrait ? size.width * 0.85 : size.width * 0.65;
    final fontSize = size.width < 600 ? 16.0 : 20.0;
    final cardColor = size.width < 600 ? Colors.orange : Colors.teal; // Noticeable color change

    return Container(
      width: cardWidth.clamp(200, 450),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}