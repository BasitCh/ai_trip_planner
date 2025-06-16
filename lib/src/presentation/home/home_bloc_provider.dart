import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/blocs/modal/modal_bloc.dart';

class HomeBlocProvider extends StatelessWidget {
  const HomeBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: BlocProvider.of<ModalBloc>(context)),
          
      ],
      child: child,
    );
  }
}
