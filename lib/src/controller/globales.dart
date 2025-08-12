import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class Sesion extends GetxController {


  static Rx<User?> user = Rx<User?>(null);
  @override
  void onInit() {
    print('Sesion controller inicializado');
    Get.put(Sesion());
    super.onInit();
  }

  void _setUser(User? nuevoUsuario) {
    user.value = nuevoUsuario;
    update(); // Notifica a los widgets que usan GetBuilder
  }

  void _limpiarSesion() {
    user.value = null;
    update();
  }

  User? get usuarioActual => user.value;
  set usuarioActual(User? nuevoUsuario) {
    user.value = nuevoUsuario;
    update();
  }

  static User? get usuario => user.value;
  static void setUsuario(User? nuevoUsuario) {
    final controller = Get.find<Sesion>();
    controller._setUser(nuevoUsuario);
  }
  static void limpiarSesion() {
    final controller = Get.find<Sesion>();
    controller._limpiarSesion();
  }


}
