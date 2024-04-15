import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_log/src/model/item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._firestore) : super(CartInitial());
  final FirebaseFirestore _firestore;
  List<ItemModel> cartList = [];
  Future addToCart(ItemModel? item) async {
    if (item != null) {
      cartList.add(item);
      emit(AddToCart(number: Random().nextInt(100)));
      print(cartList);
    }
  }

  Future removeFromCart(ItemModel? item) async {
    if (item != null) {
      cartList.remove(item);
      emit(AddToCart(number: Random().nextInt(100)));
      print(cartList);
    }
  }

  Future removeAll() async {
    cartList.clear();
    emit(AddToCart(number: Random().nextInt(100)));
    print(cartList);
  }

  Future confirmOrder(String tableNumber) async {
    // _firestore.collection('OrderHistory').doc().set();
  }
}
