// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:menu_log/commons/controls/custom_text.dart';
import 'package:menu_log/src/model/item_model.dart';
import 'package:menu_log/src/repository/cart/cart_cubit.dart';
import 'package:menu_log/utils/app_color.dart';
import 'package:menu_log/utils/string_constant.dart';

import '../../menu/menu.dart';

class TableCardGrid extends StatefulWidget {
  const TableCardGrid({
    Key? key,
    this.listOfTables,
  }) : super(key: key);
  final List<ItemModel>? listOfTables;

  @override
  State<TableCardGrid> createState() => _TableCardGridState();
}

class _TableCardGridState extends State<TableCardGrid> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const MenuPage();
                }));
              },
              child: Container(
                  // width: 100,
                  // height: 100,
                  padding: EdgeInsets.all(5),
                  // color: AppColor.forumTimeText,
                  child: Column(
                    children: [
                      Image.network(
                        'https://www.tasteofhome.com/wp-content/uploads/2018/01/Crispy-Fried-Chicken_EXPS_TOHJJ22_6445_DR-_02_03_11b.jpg?fit=700,700',
                        height: 100.h,
                        width: 200.h,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  fontName: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                  size: 14.h,
                                  text: widget.listOfTables?[index].name
                                          .toString() ??
                                      ''),
                              CustomText(
                                  size: 12.h,
                                  text: widget.listOfTables?[index].price
                                          .toString() ??
                                      ''),
                              CustomText(
                                  size: 12.h,
                                  text: widget.listOfTables?[index].category
                                          .toString() ??
                                      '')
                            ],
                          ),
                          //add button here
                        ],
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  context
                      .read<CartCubit>()
                      .addToCart(widget.listOfTables?[index]);
                },
                icon: Icon(
                  Icons.add_circle,
                  color: AppColor.subBlue,
                ),
                iconSize: 26,
              ),
            )
          ],
        );
      }, childCount: widget.listOfTables?.length),
    );
  }
}
