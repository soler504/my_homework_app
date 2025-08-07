import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? get user => _auth.currentUser;
  bool get isLoggedIn => user != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      unawaited(_googleSignIn.initialize(clientId: Platform.isAndroid ? '1:544423687769:android:e65a7c26d419bba9f32348': null,
      serverClientId: '544423687769-0cfnsv0j0ts8i3vf9da6h0s3853bbiet.apps.googleusercontent.com'));
      
      // Iniciar el flujo de autenticación con Google
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Obtener los detalles de autenticación
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Crear una credencial para Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase con la credencial de Google
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      notifyListeners();
      return userCredential;
    } catch (e) {
      debugPrint('Error en login con Google: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    notifyListeners();
  }
}