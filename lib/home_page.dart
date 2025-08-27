import 'package:flutter/material.dart';
import 'widgets/profile_card.dart'; // Import the custom widgets
import 'widgets/like_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widgets'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileCard(
                name: 'Aye Aye',
                email: 'aye@yha.com',
                imageUrl: 'https://www.perfocal.com/blog/content/images/size/w960/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg',
              ),
              SizedBox(height: 20),
              ProfileCard(
                name: 'Aung Aung',
                email: 'aung@yha.com',
                imageUrl: 'https://t4.ftcdn.net/jpg/04/31/64/75/360_F_431647519_usrbQ8Z983hTYe8zgA7t1XVc5fEtqcpa.jpg',
              ),
              SizedBox(height: 40),
              LikeButton(initialLikes: 5),
              SizedBox(height: 20),
              LikeButton(initialLikes: 42),
            ],
          ),
        ),
      ),
    );
  }
}