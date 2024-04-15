import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_log/service_locator.dart';
import 'package:menu_log/src/repository/order_menu/order_menu_cubit.dart';
import 'src/repository/login/login_bloc.dart';
import 'src/repository/table/table_cubit.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(sl(), sl()),
      ),

      //-------Cubits
      BlocProvider<TableCubit>(
        create: (_) => TableCubit(sl()),
      ),
      BlocProvider<OrderMenuCubit>(
        create: (_) => OrderMenuCubit(sl()),
      ),
    ], child: child);
  }
}
