import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> singInConEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Error al iniciar sesion: $e');
      return null;
    }
  } // Aquí puedes agregar métodos para manejar la autenticación

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize();
    try {
      final account = await _googleSignIn.authenticate();
      
      final auth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        // accessToken: auth.accessToken,
        idToken: auth.idToken, // ⚠️ Verificar no sea null
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      return Future.error('Error al iniciar sesión con Google: $e');
    }
  }
}
