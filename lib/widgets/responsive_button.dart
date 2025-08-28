import 'package:flutter/material.dart';

class ResponsiveButton extends StatefulWidget {
  const ResponsiveButton({super.key});

  @override
  State<ResponsiveButton> createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final baseWidth = size.width < 600 ? 120.0 : 180.0;
    final buttonColor = size.width < 600 ? Colors.purple : Colors.blue; // Noticeable color

    return GestureDetector(
      onTap: () => setState(() => _isPressed = !_isPressed),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isPressed ? baseWidth * 1.3 : baseWidth,
        height: size.width < 600 ? 44.0 : 52.0,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Tap Me',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width < 600 ? 14.0 : 16.0,
            ),
          ),
        ),
      ),
    );
  }
}