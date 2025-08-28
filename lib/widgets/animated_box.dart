import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  bool _isBig = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseSize = screenWidth < 600 ? 80.0 : 120.0;

    return GestureDetector(
      onTap: () => setState(() => _isBig = !_isBig),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isBig ? baseSize * 1.4 : baseSize,
        height: _isBig ? baseSize * 1.4 : baseSize,
        color: _isBig ? Colors.blue : Colors.green,
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isBig ? 0.6 : 1.0,
            child: Text(
              'Tap',
              style: TextStyle(color: Colors.white, fontSize: screenWidth < 600 ? 12 : 14),
            ),
          ),
        ),
      ),
    );
  }
}