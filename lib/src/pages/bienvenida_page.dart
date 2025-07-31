import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

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
            BlendMode.modulate,
          ),
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'Bienvenido a my Homework App',
                  style: TextStyle(fontSize: 40, color: Colors.black,fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                  
                ),
                SizedBox(height: 20),
                Boton(
                  onpressed: () {
                    context.push("/login");
                  }, 
                  texto: "Iniciar Sesión",),
                SizedBox(height: 10),
                Boton(
                  onpressed: () {
                    context.push("/registro");
                  },
                  texto: 'Registrarse',
                  
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}