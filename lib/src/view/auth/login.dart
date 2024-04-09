import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_log/commons/controls/custom_button.dart';
import 'package:menu_log/src/controller/login/login_bloc.dart';
import 'package:menu_log/utils/app_color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'Google SignIn',
            textColor: AppColor.white,
            onTap: () {
              context.read<LoginBloc>().add(OnGoogleLogin(context: context));
            },
          ),
        ],
      ),
    );
  }
}
