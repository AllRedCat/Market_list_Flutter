import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;
import 'dart:io' show Platform;

// ValueNotifier<AuthService> authService = ValueNotifier(AuthService());
late final ValueNotifier<AuthService> authService;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  static void initialize() async {
    String? clientId;
    if (kIsWeb) {
      clientId =
          '610331473800-q3skut3vljuigkl7drmloov38gqab7s0.apps.googleusercontent.com';
    } else if (Platform.isIOS || Platform.isMacOS) {
      clientId =
          '610331473800-l04a64v0babknvn34eg4iohdqi4ste36.apps.googleusercontent.com';
    } else if (Platform.isAndroid) {
      clientId =
          '610331473800-vus19h6kmk8tq1hj5q1ifk85v649jqqd.apps.googleusercontent.com';
    }

    await GoogleSignIn.instance.initialize(
      clientId: clientId,
      serverClientId:
          '610331473800-q3skut3vljuigkl7drmloov38gqab7s0.apps.googleusercontent.com',
    );
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserCredential> register({
    required String email,
    required String password,
    String? name,
  }) async {
    isLoading.value = true;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (name != null && name.isNotEmpty) {
        await credential.user?.updateDisplayName(name);
        await credential.user?.reload();
      }

      return credential;
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    isLoading.value = true;
    try {
      // Trigger the authentication flow using the custom API version
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // In this version, accessToken is obtained via authorizationClient
      final authz = await googleUser.authorizationClient
          .authorizeScopes(['email', 'profile']);

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: authz.accessToken,
        idToken: googleAuth.idToken,
      );

      developer.log('Credential created successfully');

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      developer.log('GoogleSignInException: ${e.code} - ${e.description}');
      throw Exception('Erro Google (${e.code}): ${e.description}');
    } catch (e) {
      developer.log('Erro desconhecido no login Google: $e');
      throw Exception('Erro inesperado: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  Future<void> updateUsername({required String username}) async {
    await _auth.currentUser?.updateDisplayName(username);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await _auth.signOut();
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}
