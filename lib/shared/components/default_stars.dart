import 'package:flutter/material.dart';

class DefaultStars extends StatefulWidget {
  final double voteAverage;
  const DefaultStars({super.key, required this.voteAverage});

  @override
  State<DefaultStars> createState() => _DefaultStarsState();
}

class _DefaultStarsState extends State<DefaultStars> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: List.generate(
          widget.voteAverage.floor().clamp(0, 5),
          (i) => const Icon(Icons.star, size: 16, color: Colors.yellow),
        ),
      ),
    );
  }
}
