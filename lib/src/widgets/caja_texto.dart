import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  CampoTexto({super.key, 
  required this.controler, 
  required this.labeltext, 
  required this.prefixicon, 
  required this.hinttext, 
  required this.keyboardType, 
  required this.suffixicon, 
  required this.onchanged, 
  this.color = Colors.green, 
  this.obscuretext = false, 
  this.bordercolor = Colors.green});

  final TextEditingController controler;
  final String labeltext;
  final IconData prefixicon;
  final String hinttext;
  final TextInputType keyboardType;
  final suffixicon;
  final Function(dynamic) onchanged;
  final Color color;
  final bool obscuretext;
  final Color bordercolor;
  final List<String> especialChars = ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '{', '}', '[', ']', ':', ';', '"', "'", '<', '>', ',', '.', '?', '/'];
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controler,
      onChanged: onchanged,
      obscureText: obscuretext,
      keyboardType: keyboardType,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        labelText: labeltext,
        prefixIcon: Icon(prefixicon, color: color),
        hintText: hinttext,
        suffixIcon: suffixicon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: bordercolor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: bordercolor, width: 2.0),
        ),
      ),
    );
  }
}