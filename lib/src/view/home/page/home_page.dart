import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:menu_log/commons/controls/custom_button.dart';
import 'package:menu_log/commons/controls/custom_text.dart';
import 'package:menu_log/src/model/item_model.dart';
import 'package:menu_log/src/repository/items/items_cubit.dart';
import 'package:menu_log/src/view/home/widget/home_drawer.dart';
import 'package:menu_log/src/view/home/widget/table_card.dart';
import 'package:menu_log/src/view/menu/menu.dart';
import 'package:menu_log/utils/extension.dart';
import 'package:menu_log/utils/string_constant.dart';
import '../../../../utils/app_color.dart';
import '../widget/home_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.userCredential});
  final UserCredential userCredential;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ItemsCubit>().getItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<ItemsCubit>().getItems();
      },
      child: Scaffold(
          appBar: AppBar(
            title: CustomText(
                size: 14.h,
                text:
                    "Welcome ${widget.userCredential.user?.displayName ?? ''}"),
            actions: [
              ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.network(
                  widget.userCredential.user?.photoURL ??
                      'https://i.pinimg.com/736x/01/de/87/01de8790415df8a899fb0420458c4a9c.jpg',
                  height: 40,
                  width: 40,
                ),
              ).addMargin(EdgeInsets.all(5.h)),
              Gap(5.h)
            ],
          ),
          bottomNavigationBar: HomeBottomSheet(),
          drawer: HomeDrawer(),
          body: SafeArea(
            child: CustomScrollView(slivers: [
              BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsLoaded) {
                    return TableCardGrid(
                      listOfTables: state.modelList,
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                  }
                },
              ),
              SliverToBoxAdapter(child: Gap(20.h)),
            ]),
          )),
    );
  }
}
