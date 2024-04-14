// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  LoginBloc(this._auth, this._googleSignIn) : super(LoginInitial()) {
    on<OnGoogleLogin>(onLoginWithGoogle);
    on<OnGoogleLogout>(onLogoutGoogle);
    on<OnEmailLogin>(onEmailLogin);
    on<OnEmailSignUp>(onEmailSignUp);
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

  FutureOr<void> onEmailLogin(
      OnEmailLogin event, Emitter<LoginState> emit) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (kDebugMode) {
        print(userCredential);
      }

      FirebaseFirestore.instance
          .collection('User')
          .doc(userCredential.user?.email)
          .set({
        "email": userCredential.user?.email,
        "name": userCredential.user?.displayName,
      });
      await toHomePage(event.context, userCredential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  FutureOr<void> onEmailSignUp(
      OnEmailSignUp event, Emitter<LoginState> emit) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      print(userCredential);
      await toHomePage(event.context, userCredential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
