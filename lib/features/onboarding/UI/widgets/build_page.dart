import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({super.key, required this.imagePath, required this.title, required this.describtion});
  final String imagePath;
  final String title;
  final String describtion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, 
              ),
              Text(
                describtion,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center, 
              ),
            ],
          ),
        ),
      ],
    );
  }
}
