import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_log/service_locator.dart';
import 'package:menu_log/src/repository/cart/cart_cubit.dart';
import 'package:menu_log/src/repository/items/items_cubit.dart';
import 'src/repository/login/login_bloc.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(sl(), sl(), sl()),
      ),

      //-------Cubits
      BlocProvider<ItemsCubit>(
        create: (_) => ItemsCubit(sl()),
      ),
      BlocProvider<CartCubit>(
        create: (_) => CartCubit(sl()),
      ),
    ], child: child);
  }
}
