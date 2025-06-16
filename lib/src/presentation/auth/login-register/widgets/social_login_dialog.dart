import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/login_register/login_register_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/enum.dart';
import 'package:travel_hero/src/presentation/auth/login-register/widgets/login_register_bloc_provider.dart';
import 'package:travel_hero/src/presentation/auth/login-register/widgets/social_login_button.dart';
import 'package:widgets_book/widgets_book.dart';

class SocialLoginDialog extends StatelessWidget {
  const SocialLoginDialog(
      {super.key,
      required this.appButton,
      required this.text,
        required this.loginRegisterMethod,
      required this.logo});

  final Function appButton;
  final String text;
  final Widget logo;
  final LoginRegisterMethod loginRegisterMethod;

  @override
  Widget build(BuildContext context) {
    return  LoginRegisterBlocProvider(
      child: Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
          builder: (context, state) {
            LoginRegisterCubit loginRegisterCubit = context.read<LoginRegisterCubit>();
            return Container(
              //width: MediaQuery.of(context).size.width * 0.85,
              //height: MediaQuery.of(context).size.width /2,
                padding: EdgeInsets.all(12.0),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(40),
                    Column(
                      children: [
                        Assets.icons.icLogoDialog.svg(),
                        Gap(8),
                        Text(
                          localizations.wants_to_access_your_data_on,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontFamily: FontFamily.inter,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        Gap(22),
                        logo,
                      ],
                    ),
                    Gap(20),
                    // Facebook Button
                    SocialLoginButton(
                      isLoading: state.isSubmitting && state.isSocial ,
                      text: text,
                      appButton: appButton,
                      onPressed: () {
                        loginRegisterCubit.signUpWithSocial(loginRegisterMethod);
                      },
                    ),
                    Gap(22),
                    // Terms and Conditions Text
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.w, right: 12.w),
                      child: Text(
                        localizations.sign_up_text,
                        style: TextStyle(
                            fontSize: 8.sp,
                            color: AppColors.primary75,
                            fontFamily: FontFamily.inter,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary75,
                            height: 2,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(40),
                  ],
                ));
          })


        ),
      ),
    );

  }
}
