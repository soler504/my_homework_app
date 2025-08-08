import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final contraController = TextEditingController();
  bool _contraVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.only(top: 280.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bienvenido!!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    TextField(
                      controller: usuarioController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: 'Email',
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 10),
                    TextField(
                      controller: contraController,
                      obscureText: !_contraVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: 'Crea tu Contraseña',
                        prefixIcon: Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _contraVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _contraVisible = !_contraVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          if (!usuarioController.text.contains('@unah.hn')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('El email debe contener @unah.hn'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          final specialCharRegExp = RegExp(r'[!@#$%&*().?:|<>]');
                          if (contraController.text.length < 6 || !specialCharRegExp.hasMatch(contraController.text)) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text("La contraseña debe tener al menos 6 caracteres y un carácter especial."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          context.push('/home');
                        },
                        child: Text(
                          'Siguiente',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
          
                    //Botones de redes 
                    const SizedBox(height: 18),
                    Center(child: Text("or", style: TextStyle(color: Colors.white70))),
                    const SizedBox(height: 18),
                    _socialButton(
                      context,
                      icon: Icons.facebook,
                      text: 'Continua con Facebook',
                      color: Colors.blue[800]!,
                    ),
                    const SizedBox(height: 10),
                    _socialButton(
                      context,
                      icon: Icons.g_mobiledata_sharp,
                      text: 'Contiuna con Google',
                      color: Colors.redAccent,
                    ),
                    const Spacer(),
          
                    //Espacio para la zona inferior
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No tienes una cuenta?", style: TextStyle(color: Color.fromARGB(255, 91, 42, 175))),
                        TextButton(
                          onPressed: () {
                            context.goNamed('Registro');
                          },
                          child: Text('Registrate', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
                        )
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () => {},
                        child: Text("Olvidaste tu contraseña?", style: TextStyle(color: Color.fromARGB(255, 91, 42, 175))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        ),
      )
    );  
  }

  Widget _socialButton(BuildContext context,
      {required IconData icon, required String text, required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 14),
          elevation: 2,
        ),
        onPressed: () {},
        icon: Icon(icon, color: color),
        label: Text(text),
      ),
    );
  }
}