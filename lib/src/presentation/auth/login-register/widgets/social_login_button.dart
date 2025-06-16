import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {super.key,
      required this.text,
      required this.appButton,
        required this.isLoading,
      required this.onPressed});

  final String text;
  final Function appButton;
  final VoidCallback onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return buildSocialLoginButton(text,appButton,onPressed,isLoading);
  }
}

Widget buildSocialLoginButton(
    String text, Function appButton, VoidCallback onPressed,bool isLoading) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          spreadRadius: 1,

          // Slightly dark shadow
          blurRadius: 10, // Soft edge for shadow
          offset: Offset(0, 7), // Shadow slightly below the container
        ),
      ],
    ),
    child: appButton(
      // Optional: adjust the elevation for the AppButton itself
      onPressed: onPressed,
      child: isLoading? const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: AppButtonLoading(
          color: AppColors.textPrimary,
        ),
      ):Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appButton == AppButton.white
              ? Assets.icons.icGoogle.svg()
              : appButton == AppButton.black
                  ? Assets.icons.icApple.svg()
                  : Assets.icons.icFacebook.svg(),
          SizedBox(width: 8), // Add space between icon and text
          Text(
            appButton == AppButton.white
                ? localizations.continue_with_google
                : appButton == AppButton.black
                    ? localizations.continue_with_apple
                    : localizations.continue_with_facebook,
            style: TextStyle(
              color: appButton == AppButton.white
                  ? AppColors.black.withOpacity(.54)
                  : AppColors.white,
              fontFamily: FontFamily.inter,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
