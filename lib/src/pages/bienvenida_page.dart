import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            Colors.white.withAlpha(150),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Center(
        child: Text(
          'Bienvenido a My Homework',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}