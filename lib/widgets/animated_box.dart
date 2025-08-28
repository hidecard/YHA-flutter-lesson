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
    return GestureDetector(
      onTap: () => setState(() => _isBig = !_isBig),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isBig ? 150 : 100,
        height: _isBig ? 150 : 100,
        color: _isBig ? Colors.blue : Colors.green,
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isBig ? 0.5 : 1.0,
            child: const Text('Tap me!', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}