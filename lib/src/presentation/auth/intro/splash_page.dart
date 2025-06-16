import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/splash/splash_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/auth/intro/splash_bloc_provider.dart';
import 'package:travel_hero/src/presentation/auth/intro/widgets/splash_logo.dart';
import 'package:widgets_book/widgets_book.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    localizations = AppLocalizations.of(context)!;
    theme = Theme.of(context);
    return SplashBlocProvider(
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
              body: Container(
            width: context.width,
            height: context.height,
            alignment: Alignment.bottomCenter,
            decoration: backgroundDecoration,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 255.h,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SplashLogo(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
