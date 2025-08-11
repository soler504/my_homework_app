import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_homework_app/src/services/auth_service.dart';

import 'package:my_homework_app/src/widgets/caja_texto.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _isLoading = false;
  final _auth = AuthService();
  final GoogleSignIn signIn = GoogleSignIn.instance;
  final String clientId =
      '544423687769-32r1tds8c2lee25jrnurt47emtuh8t89.apps.googleusercontent.com';
  final String serverClientId =
      '544423687769-0cfnsv0j0ts8i3vf9da6h0s3853bbiet.apps.googleusercontent.com';
  final contraController = TextEditingController();

  final emailController = TextEditingController();

  List<String> especialChars = [
    '@',
    '.',
    '_',
    '-',
    '+',
    '!',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '*',
    '(',
    ')',
    '=',
    '{',
    '}',
    '[',
    ']',
    ':',
    ';',
    '"',
    "'",
    '<',
    '>',
    '?',
    '/',
    '\\',
  ];
  bool hasSpecialChar = false;
  Color colorEmailCheck = Colors.black;
  Color borderColor = Colors.red;
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(20.0),
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

            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CampoTexto(
                controler: emailController,
                labeltext: 'Correo Electrónico',
                prefixicon: Icons.email_outlined,
                hinttext: 'Ingrese su correo electrónico',
                keyboardType: TextInputType.emailAddress,
                suffixicon: Icon(
                  Icons.check_circle_outline,
                  color: colorEmailCheck,
                ),
                onchanged: (value) {},
                color: colorEmailCheck,
              ),
              const SizedBox(height: 20),
              CampoTexto(
                controler: contraController,
                labeltext: 'Contraseña',
                prefixicon: Icons.lock_outline,
                hinttext: 'Ingrese su contraseña',
                obscuretext: isPassword,
                bordercolor: borderColor,
                suffixicon: IconButton(
                  icon: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                ),
                onchanged: (value) {
                  setState(() {
                    for (String char in especialChars) {
                      if (contraController.text.contains(char)) {
                        // print('Caracter especial encontrado: $char');
                        hasSpecialChar = true;
                        break;
                      } else {
                        hasSpecialChar = false;
                      }
                    }
                    if (contraController.text.length < 6 ||
                        hasSpecialChar == false) {
                      borderColor = Colors.red;
                    } else {
                      borderColor = Colors.green;
                    }
                  });
                  // Aquí puedes agregar lógica para validar la contraseña si es necesario
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              Boton(
                onpressed: () async {
                  // Handle login logic

                  if (contraController.text.isEmpty ||
                      contraController.text.length < 6 ||
                      hasSpecialChar == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Contraseña debe tener al menos 6 caracteres y almenos un caracter especial',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      snackBarAnimationStyle: AnimationStyle(
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2),
                        reverseDuration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  try{
                    final usuario = await _auth.singInConEmail(emailController.text, contraController.text);
                    if (usuario==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Error al iniciar sesión, usuario o contraseña incorrectos',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        snackBarAnimationStyle: AnimationStyle(
                          curve: Curves.easeInOut,
                          duration: Duration(seconds: 2),
                          reverseDuration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sesión iniciada, bienvenido ${usuario?.displayName}!')),
                      );
                      // Navegar a la pantalla principal después de iniciar sesión exitosamente 
                      print('usuario: ${usuario?.displayName}');
                      context.go('/home_layout', extra: {'user': usuario});
                    }
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Error al iniciar sesión: $e',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      snackBarAnimationStyle: AnimationStyle(
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2),
                        reverseDuration: Duration(seconds: 2),
                      ),
                    );
                  }

                },
                texto: "Iniciar Sesión",
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.black87, thickness: 2),
              const SizedBox(height: 20),
              Text(
                'Iniciar sesión con',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Boton(
                onpressed: () async {
                  try {
                    print('Iniciar sesión con Google');
                    final userCredential = await _auth.signInWithGoogle();
                    // logica para acceder con google
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sesión iniciada con Google, bienvenido ${userCredential.user?.displayName}!')),
                      );
                      // Navegar a la pantalla principal después de iniciar sesión exitosamente 
                      print('userCredential: ${userCredential.user}');
                      final user = userCredential.user;
                      print('user: ${user?.displayName}');

                      context.go('/home_layout', extra: {'user': user, 'page': 'home'});
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al iniciar sesión con Google: $e'),
                      ),
                    );
                  }
                },
                texto: 'Google',
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.push('/registro');
                },
                child: Text(
                  '¿No tienes una cuenta? Regístrate aquí',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
