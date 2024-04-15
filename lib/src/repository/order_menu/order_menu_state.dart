part of 'order_menu_cubit.dart';

sealed class OrderMenuState extends Equatable {
  const OrderMenuState();

  @override
  List<Object> get props => [];
}

final class OrderMenuInitial extends OrderMenuState {}
