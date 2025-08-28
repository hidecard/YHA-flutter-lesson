import 'package:flutter/material.dart';
import 'widgets/responsive_card.dart';
import 'widgets/responsive_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YHA Lesson')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
          if (constraints.maxWidth < 600 || !isPortrait) {
            // Mobile or landscape: Vertical Column
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: const [
                      ResponsiveCard(title: 'Card 1'),
                      ResponsiveCard(title: 'Card 2'),
                      ResponsiveCard(title: 'Card 3'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ResponsiveButton(),
                ),
              ],
            );
          } else {
            // Tablet/Web (portrait): GridView
            return GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: const [
                ResponsiveCard(title: 'Card 1'),
                ResponsiveCard(title: 'Card 2'),
                ResponsiveCard(title: 'Card 3'),
                ResponsiveButton(),
              ],
            );
          }
        },
      ),
    );
  }
}