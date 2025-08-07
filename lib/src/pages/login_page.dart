import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/services/auth_service.dart';
import 'package:my_homework_app/src/widgets/caja_texto.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(); 
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  

  final contraController = TextEditingController();

  final emailController = TextEditingController();

  List<String> especialChars = ['@', '.', '_', '-', '+', '!', '#', '\$', '%', '^', '&', '*', '(', ')', '=', '{', '}', '[', ']', ':', ';', '"', "'", '<', '>', '?', '/', '\\'];
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
            fit: BoxFit.cover
            ),
          ),
        child: Container(
          margin: const EdgeInsetsDirectional.only(
            start: 20.0,
            end: 20.0,
          ),
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
              Text('Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
              const SizedBox(height: 20),
              CampoTexto(
                    controler: emailController,
                    labeltext: 'Correo Electrónico',
                    prefixicon: Icons.email_outlined,
                    hinttext: 'Ingrese su correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    suffixicon: Icon(Icons.check_circle_outline, color: colorEmailCheck),
                    onchanged: (value) {
                      
                    },
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
                        if (contraController.text.length < 6 || hasSpecialChar == false) {
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
            Boton(onpressed: () {
                  // Handle login logic
                  
                    
                  
                  
                  if (contraController.text.isEmpty || contraController.text.length < 6 || hasSpecialChar == false)  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Contraseña debe tener al menos 6 caracteres y almenos un caracter especial', 
                                style: TextStyle(color: Colors.black),)
                        ), 
                      snackBarAnimationStyle: AnimationStyle(
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2),
                        reverseDuration: Duration(seconds: 2),
                      )
                    );
                    return;
                  }
                }, texto: "Iniciar Sesión",),
              const SizedBox(height: 20),
              Divider(color: Colors.black87, thickness: 2,),   
              const SizedBox(height: 20),
              Text('Iniciar sesión con',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
              const SizedBox(height: 20),
              Boton(onpressed:this._isLoading ? (){} : () 
                        async {setState(() => _isLoading = true);
                        try {
                          await Provider.of<AuthService>(context, listen: false)
                              .signInWithGoogle();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${e.toString()}'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
                      }, texto: this._isLoading ? 'Procesando ':'Google', icon: this._isLoading ? 
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ) : Icon(Icons.login, color: Colors.white)),
              FilledButton(onPressed: () async {}, child: Text('Iniciar sesión con Google', style: TextStyle(color: Colors.white))),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                 context.push('/registro');
                },
                child: Text('¿No tienes una cuenta? Regístrate aquí',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}