import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_log/commons/controls/custom_text.dart';
import 'package:menu_log/src/view/menu/menu.dart';
import 'package:menu_log/utils/extension.dart';

import '../../../../commons/controls/custom_button.dart';
import '../../../../utils/app_color.dart';
import '../../../controller/login/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userCredential});
  final UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.network(
                    userCredential.user?.photoURL ??
                        'https://i.pinimg.com/736x/01/de/87/01de8790415df8a899fb0420458c4a9c.jpg',
                    height: 40,
                    width: 40,
                  ),
                ),
                CustomText(text: userCredential.user?.displayName ?? ''),
              ]),
        ),
        SliverGrid(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.90,
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,

          ),
          delegate:
              SliverChildBuilderDelegate(
                (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const MenuPage();
                }));
              },
              child: SizedBox(
                child: Image.network(
                  'https://i.pinimg.com/736x/01/de/87/01de8790415df8a899fb0420458c4a9c.jpg',
                ),
              ).addMargin(const EdgeInsets.only(left: 10, right: 10)),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: CustomButton(
            text: 'Google logout',
            textColor: AppColor.white,
            onTap: () {
              context.read<LoginBloc>().add(OnGoogleLogout());
            },
          ),
        )
      ]),
    ));
  }
}
