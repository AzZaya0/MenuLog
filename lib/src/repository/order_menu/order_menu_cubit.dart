// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_log/src/model/order_menu_model.dart';

part 'order_menu_state.dart';

class OrderMenuCubit extends Cubit<OrderMenuState> {
  OrderMenuCubit(
    this._firestore,
  ) : super(OrderMenuInitial());
  final FirebaseFirestore _firestore;
  Future createMenuTable() async {
    _firestore.collection('categories').doc("Catagories_ID").set(OrderMenuModel(
            menu: Menu(categories: [
          Category(name: 'Coffee', items: [
            Item(name: 'late', price: 500),
            Item(name: 'mokka', price: 500)
          ])
        ])).toJson());
  }
}
