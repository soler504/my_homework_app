import 'package:flutter/material.dart';


class Boton extends StatelessWidget {
  const Boton({super.key, required this.onpressed, required this.texto, this.ancho = 300, this.alto = 50, this.icon});
  
  final void Function() onpressed;
  final String texto;
  final double ancho;
  final double alto;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        
        fixedSize: Size(ancho, alto),
        textStyle: TextStyle(fontSize: 20),
      ),
      onPressed: onpressed, 
      
      child: Text(texto,
        style: TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          ),
      ),
    );
  }
}