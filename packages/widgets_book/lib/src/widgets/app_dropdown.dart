// ignore_for_file: inference_failure_on_function_return_type

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.hintText,
    required this.onChanged,
    required this.data,
    required this.label,
    super.key,
    this.value,
    this.validator,
    this.errorMessage,
    this.isCompulsory = true,
    this.enableValidation = true,
  });

  final T? value;
  final String hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> data;
  final String? label;
  final bool? isCompulsory;
  final bool enableValidation;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              isCollapsed: false,
              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.1),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondary,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.white.withOpacity(.1),
                ),
              ),
              errorStyle: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                color: AppColors.secondary,
              ),
              filled: true,
              fillColor: AppColors.white800,
              contentPadding: const EdgeInsets.only(
                right: 15,
                top: 15,
                bottom: 15,
              ),
            ),
            value: value,
            // iconEnabledColor: AppColors.white.withOpacity(.1),
            hint: StandardText.subtitle3(
              hintText,
              color: AppColors.gray,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            onChanged: onChanged,
            validator: (value) {
              if (enableValidation) {
                if (value == null) {
                  return errorMessage != null ? '   $errorMessage' : '   Field can not be empty or null';
                }
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            iconSize: 25,
            icon: Transform.rotate(
              angle: -pi / 2,
              child: const Icon(
                Icons.chevron_left,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),
            padding: EdgeInsets.zero,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            style: theme.textTheme.labelSmall
                ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            items: data,
          ),
        ),
        if (label != null)
          Container(
            margin: EdgeInsets.only(left: 12.h),
            transform: Matrix4.translationValues(0, -10, 0),
            child: RichText(
              text: TextSpan(
                text: label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.saira,
                  // (focusNode != null && focusNode!.hasFocus && validate != null && !validate!)
                  //     ? Colors.red
                  //     : (focusNode != null && focusNode!.hasFocus && validate != null && validate!)
                  //         ? AppColors.textPrimary
                  //         : AppColors.textPrimary,
                ),
                children: [
                  if (isCompulsory!)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                ],
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
