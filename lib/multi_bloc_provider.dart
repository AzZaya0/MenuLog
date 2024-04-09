import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'service_locator.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider<LoginBloc>(
      //   create: (_) => LoginBloc(sl()),
      // ),

      //-------Cubits
    ], child: child);
  }
}
