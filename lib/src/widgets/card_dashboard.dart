import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final IconData? iconData;
  final Color? iconColor;
  final String? texto1;
  final String? texto2;

  const CardDashboard({
    super.key,
    this.width,
    this.height,
    this.iconSize,
    this.iconData,
    this.iconColor,
    this.texto1,
    this.texto2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(iconData, color: iconColor, size: iconSize),
              Text(
                texto1 ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(texto2 ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}