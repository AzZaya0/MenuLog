import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_log/commons/controls/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userCredential});
  final UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(userCredential.user?.photoURL ?? ''),
            ),
            CustomText(text: userCredential.user?.displayName ?? '')
          ],
        ),
      ),
    );
  }
}
