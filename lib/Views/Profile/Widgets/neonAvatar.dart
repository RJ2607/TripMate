import 'package:flutter/material.dart';

class NeonAvatar extends StatelessWidget {
  final String imagePath;

  NeonAvatar({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 20,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.14,
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}
