import 'package:flutter/material.dart';
import 'package:my_homework_app/src/widgets/caja_texto.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

class RegistroPage extends StatelessWidget {
   RegistroPage({super.key});
  // Aquí puedes definir los controladores de texto si es necesario
  final nombre = TextEditingController();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 40.0,
            vertical: 40.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Página de Registro'),
              const SizedBox(height: 20),
              CampoTexto(
                controler: nombre,
                labeltext: 'Nombre',
                prefixicon: Icons.person,
                hinttext: 'Ingrese su nombre',
                keyboardType: TextInputType.text,
                suffixicon: null,
                onchanged: (text) {
                  // lógica para manejar el cambio de texto

                },
              ),
              const SizedBox(height: 10),
              CampoTexto(
                controler: correo, 
                labeltext: 'Correo Electrónico', 
                prefixicon: Icons.email, 
                hinttext: 'Ingrese su correo electrónico', 
                keyboardType: TextInputType.emailAddress, 
                suffixicon: null, 
                onchanged: (texto){
                  // lógica para manejar el cambio de texto
                }
              ),
              const SizedBox(height: 10),
              CampoTexto(
                controler: contrasena, 
                labeltext: 'Contraseña', 
                prefixicon: Icons.lock, 
                hinttext:   'Ingrese su contraseña', 
                keyboardType: TextInputType.visiblePassword, 
                suffixicon: null, 
                onchanged: (texto){

                }
                ),
              const SizedBox(height: 20),
              Boton(
                onpressed: () {
                  // lógica para el registro
                },
                texto: 'Registrarse',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
