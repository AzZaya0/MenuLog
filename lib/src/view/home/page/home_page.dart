import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_log/commons/controls/custom_text.dart';
import 'package:menu_log/commons/controls/custom_textfield.dart';
import 'package:menu_log/src/model/table_model.dart';
import 'package:menu_log/src/repository/order_menu/order_menu_cubit.dart';
import 'package:menu_log/src/repository/table/table_cubit.dart';
import 'package:menu_log/src/view/menu/menu.dart';
import 'package:menu_log/utils/extension.dart';

import '../../../../commons/controls/custom_button.dart';
import '../../../../utils/app_color.dart';
import '../../../repository/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.userCredential});
  final UserCredential userCredential;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TableCubit>().getTables();
    super.initState();
  }

  TextEditingController tableNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<TableCubit>().getTables();
      },
      child: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: CustomText(text: 'Create Table'),
                            content: CustomTextField(
                              controller: tableNumberController,
                              borderSide: BorderSide(),
                            ),
                            actions: [
                              CustomButton(
                                onTap: () {
                                  context
                                      .read<TableCubit>()
                                      .createTables(
                                          int.parse(tableNumberController.text))
                                      .then((value) {
                                    Navigator.of(context).pop();
                                  });
                                  //
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
                    title: CustomText(text: 'Create Tables'),
                  )
                ],
              ),
            ),
          ),
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
                          widget.userCredential.user?.photoURL ??
                              'https://i.pinimg.com/736x/01/de/87/01de8790415df8a899fb0420458c4a9c.jpg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      CustomText(
                          text: widget.userCredential.user?.displayName ?? ''),
                    ]),
              ),
              BlocBuilder<TableCubit, TableState>(
                builder: (context, state) {
                  if (state is TableLoaded) {
                    return tablesList(state.listOfTables);
                  } else {
                    return tablesList(null);
                  }
                },
              ),
              SliverToBoxAdapter(
                child: CustomButton(
                  text: 'Google logout',
                  textColor: AppColor.white,
                  onTap: () {
                    context.read<LoginBloc>().add(OnGoogleLogout());
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: CustomButton(
                  text: 'CREATE MENU',
                  textColor: AppColor.white,
                  onTap: () {
                    context.read<OrderMenuCubit>().createMenuTable();
                  },
                ),
              )
            ]),
          )),
    );
  }

  SliverGrid tablesList(List<TableModel>? listOfTables) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const MenuPage();
            }));
          },
          child: Container(
            // width: 100,
            // height: 100,
            padding: EdgeInsets.all(5),
            color: AppColor.forumTimeText,
            child: Center(
              child: Text(
                  listOfTables?[index].tableNumber.toString() ?? 0.toString()),
            ),
          ),
        );
      }, childCount: listOfTables?.length ?? 0),
    );
  }
}
