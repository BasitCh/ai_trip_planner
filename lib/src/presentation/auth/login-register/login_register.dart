import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/intro/carousel_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/enum.dart';
import 'package:travel_hero/src/presentation/auth/login-register/widgets/social_login_button.dart';
import 'package:travel_hero/src/presentation/auth/login-register/widgets/social_login_dialog.dart';
import 'package:travel_hero/widgets/shader_mask.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarouselCubit>(
      create: (context) => CarouselCubit(),
      child:LoginRegisterDetail() ,
    );
  }
}

class LoginRegisterDetail extends StatefulWidget {
  const LoginRegisterDetail({super.key});

  @override
  State<LoginRegisterDetail> createState() => _LoginRegisterDetailState();
}

class _LoginRegisterDetailState extends State<LoginRegisterDetail> {
  late List<Widget> images;
  late CarouselCubit carouselCubit;
  @override
  void initState() {
    images = [
      Assets.images.jibli1.image(width: double.infinity, fit: BoxFit.cover),
      Assets.images.jibli2.image(width: double.infinity, fit: BoxFit.cover),
      Assets.images.jibli3.image(width: double.infinity, fit: BoxFit.cover),
      Assets.images.jibli4.image(width: double.infinity, fit: BoxFit.cover),
    ];
    carouselCubit = context.read<CarouselCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            //flex: 5,
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: images[index]);
                  },
                  options: CarouselOptions(
                    height: double.infinity,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      carouselCubit.updateIndex(index);
                    },
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<CarouselCubit, int>(
                      builder: (context, activeIndex) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: images.asMap().entries.map((entry) {
                            return Container(
                              width: activeIndex == entry.key ? 13.0 : 9.0,
                              height: activeIndex == entry.key ? 13.0 : 9.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: activeIndex == entry.key
                                    ? AppColors.white
                                    : AppColors.lightGrey,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),),
              ],
            ),
          ),
          // Gap(34),
          Padding(
            padding: const EdgeInsets.only(left: 34, right: 34),
            child: Column(
              children: [
                Gap(34),
                AppShaderMask(),
                Gap(34),
                SocialLoginButton(
                    text: localizations.continue_with_facebook,
                    appButton: AppButton.blueDress,
                    isLoading: false,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SocialLoginDialog(
                            text: localizations.continue_with_facebook,
                            appButton: AppButton.blueDress,
                            loginRegisterMethod:
                            LoginRegisterMethod.facebook,
                            logo: Assets.icons.icFacebookDialog.svg(),
                          ));
                    }),
                Gap(20),
                SocialLoginButton(
                    text: localizations.continue_with_google,
                    appButton: AppButton.white,
                    isLoading:false,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SocialLoginDialog(
                            text: localizations.continue_with_google,
                            appButton: AppButton.white,
                            loginRegisterMethod: LoginRegisterMethod.google,
                            logo: Assets.icons.icGmailDialog.svg(),
                          ));
                    }),
                Gap(20),
                SocialLoginButton(
                    text: localizations.continue_with_apple,
                    appButton: AppButton.black,
                    isLoading:false,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SocialLoginDialog(
                            text: localizations.continue_with_apple,
                            appButton: AppButton.black,
                            loginRegisterMethod: LoginRegisterMethod.apple,
                            logo: Assets.icons.icAppleDialog.svg(),
                          ));
                    }),
                Gap(12),
                // RichText(
                //   textAlign: TextAlign.center,
                //   text: TextSpan(
                //     style: TextStyle(
                //         fontSize: 11,
                //         color: AppColors.primary75,
                //         fontWeight: FontWeight.w400,
                //         height: 1.5),
                //     children: [
                //       TextSpan(
                //         text: localizations.sign_up_text,
                //         style: TextStyle(
                //           decoration: TextDecoration.underline,
                //           fontFamily: FontFamily.inter,
                //           fontWeight: FontWeight.w400,
                //           fontSize: 10,
                //           color: AppColors
                //               .primary75, // Change to a color to simulate a link
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          )

        ],
      ),
    );
  }
}
