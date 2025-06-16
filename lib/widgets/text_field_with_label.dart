import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel(
      {super.key,
      this.controller,
      this.hintText,
      this.labelTitle,
      this.onChanged,
      this.margin,
        this.readOnly,
        this.textInputType,
      this.inputFormatters});

  final TextEditingController? controller;
  final String? labelTitle;
  final String? hintText;
  final Function(String value)? onChanged;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;
final TextInputType? textInputType;
final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Stack(
        //crossAxisAlignment: CrossAxisAlignment.start
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 13),
            child: Text(labelTitle ?? 'Name',
                style: titleMedium?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.shadeColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppTextField(
              onChanged: onChanged,
              readOnly: readOnly??false,
              keyboardType: textInputType,

              inputFormatters: inputFormatters,
              focusedcolor: BorderSide(
                color: AppColors.transparent,
              ),
              controller: controller,
              fillcolor: AppColors.transparent,
              maxLines: 1,
              borderRadius: 10,
              // contentPadding: EdgeInsets.only(
              //     left: 27, right: 80, top: 20, bottom: 20),
              hintText: hintText ?? 'Jane Austin',

              bordersidecolor: BorderSide(
                color: AppColors.transparent,
              ),
              hintStyle: titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.dimGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
