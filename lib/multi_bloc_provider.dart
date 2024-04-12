import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/controller/login/login_bloc.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(),
      ),

      //-------Cubits
    ], child: child);
  }
}
