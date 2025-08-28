import 'package:flutter/material.dart';
import 'dart:math' show pi;

class SpinningIcon extends StatefulWidget {
  final IconData icon;

  const SpinningIcon({super.key, required this.icon});

  @override
  State<SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<SpinningIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width < 600 ? 24.0 : 32.0;
    return GestureDetector(
      onTap: () => _controller.isCompleted ? _controller.reverse() : _controller.forward(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: Icon(widget.icon, size: iconSize, color: Theme.of(context).primaryColor),
          );
        },
      ),
    );
  }
}