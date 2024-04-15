// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:menu_log/commons/controls/custom_button.dart';
import 'package:menu_log/commons/controls/custom_text.dart';
import 'package:menu_log/commons/controls/custom_textfield.dart';
import 'package:menu_log/src/repository/items/items_cubit.dart';
import 'package:menu_log/src/repository/login/login_bloc.dart';
import 'package:menu_log/utils/app_color.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({
    super.key,
  });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController categoriesController;

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    categoriesController = TextEditingController();
    super.initState();
  }

  // TextEditingController tableNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: CustomText(text: 'Create Table'),
                      content: SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: nameController,
                              hintText: 'Item Name',
                              borderSide: BorderSide(),
                            ),
                            Gap(10.h),
                            CustomTextField(
                              hintText: 'Item Price',
                              controller: priceController,
                              borderSide: BorderSide(),
                            ),
                            Gap(10.h),
                            CustomTextField(
                              hintText: 'Item Category',
                              controller: categoriesController,
                              borderSide: BorderSide(),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        CustomButton(
                          onTap: () {
                            //

                            context.read<ItemsCubit>().createItems(
                                nameController.text.trim(),
                                categoriesController.text.trim(),
                                priceController.text.trim().toString());
                            Navigator.pop(context);
                          },
                          text: 'Save',
                          height: 50,
                          width: 150,
                          textColor: AppColor.white,
                        )
                      ],
                    );
                  },
                );
              },
              title: CustomText(text: 'Add item to menu'),
            ),
            ListTile(
              title: CustomText(text: 'Log Out'),
              onTap: () {
                context.read<LoginBloc>().add(OnGoogleLogout(context: context));
              },
            ),
            Gap(50.h)
          ],
        ),
      ),
    );
  }
}
