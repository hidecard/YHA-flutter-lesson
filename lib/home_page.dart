import 'package:flutter/material.dart';
import 'widgets/profile_card.dart';
import 'widgets/animated_box.dart';
import 'widgets/spinning_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YHA Lesson')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProfileCard(name: 'Aye Aye', email: 'aye@yha.com'),
          ProfileCard(name: 'Mg Mg', email: 'mgmg@yha.com'),
          SizedBox(height: 16),
          Center(child: AnimatedBox()),
          SizedBox(height: 16),
          Center(child: SpinningIcon(icon: Icons.star)),
        ],
      ),
    );
  }
}