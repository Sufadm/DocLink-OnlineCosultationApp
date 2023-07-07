import 'package:flutter/material.dart';

class CarousalWidget extends StatelessWidget {
  final String assetimage;
  const CarousalWidget({
    super.key,
    required this.assetimage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(assetimage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
