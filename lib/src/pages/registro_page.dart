import 'package:flutter/material.dart';
import 'package:my_homework_app/src/widgets/caja_texto.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';


class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nombreController = TextEditingController();
  final numeroController = TextEditingController();
  final emailController = TextEditingController();
  final contraController = TextEditingController();
  bool isPasswordVisible = true;
  Color colorEmailCheck = Colors.black;
  Color borderColor = Colors.red;
  

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                start: 20.0,
                end: 20.0,
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 40.0,
                vertical: 30.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  CampoTexto(
                    controler: nombreController,
                    labeltext: 'Nombre',
                    prefixicon: Icons.person_outline,
                    hinttext: 'Ingrese su nombre',
                    keyboardType: TextInputType.name,
                            
                  ),const SizedBox(height: 20),
                  CampoTexto(
                    controler: numeroController,
                    labeltext: 'Número de Teléfono',
                    prefixicon: Icons.phone_android_outlined,
                    hinttext: 'Ingrese su número de teléfono',
                    keyboardType: TextInputType.phone,
                  ),const SizedBox(height: 20),
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
                  ),const SizedBox(height: 20),
                  
                  CampoTexto(
                    controler: contraController,
                    labeltext: 'Contraseña',
                    prefixicon: Icons.lock_outline,
                    hinttext: 'Ingrese su contraseña',
                    obscuretext: isPasswordVisible,
                    suffixicon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    bordercolor: borderColor,
                    onchanged: (value) {
                        
                        setState(() {
                          if (contraController.text.length < 6) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colors.green;
                        }
                        });
                        // Aquí puedes agregar lógica para validar la contraseña si es necesario
                      },
                      keyboardType: TextInputType.visiblePassword,
                    
                  )
                  ,
                  const SizedBox(height: 20),
                  
                  Boton(onpressed: () {
                      // Logic for registration can be added here
                      if (nombreController.text.isEmpty ||
                          numeroController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          contraController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[100],
                            duration: Duration(seconds: 2),
                            content: Text(
                              'Todos los campos son obligatorios',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          
                        );
                        
                        return;
                      }
                      
                      if (!emailController.text.contains('@unah.hn')){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[100],
                            duration: Duration(seconds: 2),
                            content: Text(
                              'El correo debe ser de la UNAH',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                        return;
                      }
                            
                      if (contraController.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[100],
                            duration: Duration(seconds: 2),
                            content: Text(
                              'La contraseña debe tener al menos 6 caracteres',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                        return;
                      }
                            
                      
                      nombreController.clear();
                      numeroController.clear();
                      emailController.clear();
                      contraController.clear();
                      colorEmailCheck = Colors.black;
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green[100],
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Registro exitoso',
                             style: TextStyle(
                              color: Colors.black
                              )
                            ,)
                        )
                      );
                    }, texto: "Registrarse",),
                  const SizedBox(height: 20),
                  Divider(color: Colors.black87, thickness: 2,),   
                  const SizedBox(height: 20),
                  Text('Iniciar sesión con',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      ),
                  const SizedBox(height: 20),
                  Boton(onpressed: (){
                    // logica para acceder con google
                    print('Ingresando con google');
                  }, texto: 'Google',),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}