import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menu_log/src/view/home/page/home_page.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  LoginBloc() : super(LoginInitial()) {
    on<OnGoogleLogin>(onLoginWithGoogle);
    on<OnGoogleLogout>(onLogoutGoogle);
  }

  Future<UserCredential?> onLoginWithGoogle(
      OnGoogleLogin event, Emitter<LoginState> emit) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      var data = await _auth
          .signInWithCredential(credential)
          .then((value) => toHomePage(event.context, value));

      return data;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('exception->$e');
      }
      return null;
    }
  }

  FutureOr<void> onLogoutGoogle(
      OnGoogleLogout event, Emitter<LoginState> emit) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  toHomePage(BuildContext context, UserCredential userCredential) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => HomePage(userCredential: userCredential)));
  }
}
