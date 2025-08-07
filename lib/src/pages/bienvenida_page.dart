import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withAlpha(150),
            BlendMode.modulate,
          ),
        ),
      ),

      child: Container(
          
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 40.0,
            vertical: 40.0,
          ),
          decoration: BoxDecoration(
            
            color: Colors.white70,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: Colors.black45,
              width: 1.0,
            ),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),
            Text(
              'Bienvenido a MyHomework App',
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
      )
    )
    );
  }
}