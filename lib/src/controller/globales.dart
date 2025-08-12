import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class Sesion extends GetxController {


  static final Rx<User?> _user = Rx<User?>(null);

  @override
  void onInit() {
    print('Sesion controller inicializado');
    super.onInit();
  }

  void _setUser(User? nuevoUsuario) {
    _user.value = nuevoUsuario;
    update(); // Notifica a los widgets que usan GetBuilder
  }

  void _limpiarSesion() {
    _user.value = null;
    update();
  }

  User? get usuarioActual => _user.value;
  set usuarioActual(User? nuevoUsuario) {
    _user.value = nuevoUsuario;
    update();
  }

  static User? get usuario => _user.value;
  static void setUsuario(User? nuevoUsuario) {
    final controller = Get.find<Sesion>();
    controller._setUser(nuevoUsuario);
  }
  static void limpiarSesion() {
    final controller = Get.find<Sesion>();
    controller._limpiarSesion();
  }


}
