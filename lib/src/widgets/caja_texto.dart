

import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {

  const CampoTexto( {super.key, 
    required this.controler,
    required this.labeltext,
    required this.hinttext,
    required this.prefixicon,
    this.suffixicon,
    this.keyboardType = TextInputType.text,
    this.obscuretext,
    this.onchanged ,
    this.color = Colors.black,
    this.bordercolor = Colors.green,
  });
  final TextEditingController controler;
  final String labeltext;
  final String hinttext;
  final IconData prefixicon;
  final suffixicon;
  final TextInputType keyboardType;
  final bool? obscuretext;
  final Function(String)? onchanged;
  final Color color;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscuretext ?? false,
            controller: controler,
            keyboardType: keyboardType,
                decoration: InputDecoration(
                  hoverColor: Colors.greenAccent[100],
                  labelStyle: TextStyle(

                    color: color,
                  ),
                  labelText: labeltext,
                  contentPadding: EdgeInsets.all(22),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: bordercolor,
                      width: 2.0,
                    ),
                  ),
                  hintText: hinttext,
                  prefixIcon: Icon(prefixicon),
                  suffixIcon: suffixicon,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                ),
            onChanged: onchanged,
    );
  }
}