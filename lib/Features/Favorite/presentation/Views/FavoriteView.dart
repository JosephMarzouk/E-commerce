import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Favorite View',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        
      ],
    );
  }
}