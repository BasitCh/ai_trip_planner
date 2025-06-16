import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_book/widgets_book.dart';

class AppStandardTextField extends StatelessWidget {
  const AppStandardTextField({
    super.key,
    this.width,
    this.textFieldColor,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.controller,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.prefixText,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.maxLines = 1,
    this.inputBorder,
    this.inputFormatter,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.cursorColor,
    this.validate,
    this.readOnly = false,
    this.showCounterText = false,
    this.borderRadius = 12,
    this.filled = true,
    this.fillColor = AppColors.white800,
    this.errorHeight,
    this.disableSpacing = false,
    this.autoValidateMode,
    this.obscuringCharacter,
    this.autofillHints,
    this.isCompulsory = false,
    this.textCapitalization = TextCapitalization.words,
  });

  const AppStandardTextField.outlined({
    super.key,
    this.width,
    this.textFieldColor,
    this.borderColor = AppColors.black600,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.controller,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.prefixText,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.maxLines = 1,
    this.inputBorder,
    this.inputFormatter,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.cursorColor,
    this.validate,
    this.readOnly = false,
    this.showCounterText = false,
    this.borderRadius = 12,
    this.filled = true,
    this.fillColor = AppColors.white800,
    this.errorHeight,
    this.disableSpacing = false,
    this.autoValidateMode,
    this.obscuringCharacter,
    this.autofillHints,
    this.isCompulsory = false,
    this.textCapitalization = TextCapitalization.words,
  });

  final double? width;
  final Color? textFieldColor;
  final Color? borderColor;
  final Color? cursorColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final Widget? prefixWidget;
  final String? prefixText;
  final Widget? suffixWidget;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  final bool showPrefixIcon;
  final bool showCounterText;
  final bool showSuffixIcon;
  final bool isEnabled;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int? maxLength;
  final int? maxLines;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputBorder? inputBorder;
  final List<TextInputFormatter>? inputFormatter;
  final bool autoFocus;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool? validate;
  final bool readOnly;
  final double borderRadius;
  final Color fillColor;
  final bool filled;
  final double? errorHeight;
  final bool? disableSpacing;
  final TextStyle? textStyle;
  final AutovalidateMode? autoValidateMode;
  final String? obscuringCharacter;
  final Iterable<String>? autofillHints;
  final bool isCompulsory;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      autofillHints: autofillHints,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: '*',
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      style: textStyle ??
          theme.textTheme.labelSmall
              ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
      buildCounter: maxLength == null
          ? null
          : (
              _, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) =>
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 17),
                child: StandardText.subtitle3(
                  '$currentLength/$maxLength',
                  color: AppColors.gray,
                ),
              ),
      decoration: InputDecoration(
        fillColor: fillColor,
        counterStyle: UITextStyle.bodyText2,
        filled: filled,
        errorStyle: theme.textTheme.bodyMedium
            ?.copyWith(fontSize: 12.sp, color: AppColors.secondary),
        errorMaxLines: 2,
        hintText: hintText,
        label: labelText == null
            ? null
            : RichText(
              text: TextSpan(
                  text: ' $labelText  ',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: (focusNode != null &&
                            focusNode!.hasFocus &&
                            validate != null &&
                            !validate!)
                        ? AppColors.red
                        : (focusNode != null &&
                                focusNode!.hasFocus &&
                                validate != null &&
                                validate!)
                            ? AppColors.textPrimary
                            : AppColors.textPrimary,
                  ),
                  children: [
                    if (isCompulsory)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColors.red,
                        ),
                      ),
                  ]),
            ),
        hintStyle: hintStyle ??
            theme.textTheme.bodyMedium?.copyWith(color: AppColors.black700),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.white800,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        focusedBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.textPrimary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        focusedErrorBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.secondary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        disabledBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.white800,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        enabledBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.white800,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        contentPadding: EdgeInsets.all(16.h),
        // prefix: Padding(
        //   padding: EdgeInsets.only(left: 16.h),
        // ),
        suffixIcon: showSuffixIcon ? suffixWidget : null,
        prefixIcon: showPrefixIcon ? prefixWidget : null,
        prefixText: prefixText,
        prefixStyle: UITextStyle.bodyText1.copyWith(
          fontSize: 14.sp,
          color: AppColors.gray,
        ),
      ),
      controller: controller,
      textAlign: textAlign,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      enabled: isEnabled,
      inputFormatters: disableSpacing!
          ? [NoSpaceFormatter()]
          : inputFormatter ?? [NoLeadingSpaceFormatter()],
      autofocus: autoFocus,
      focusNode: focusNode,
      validator: validator,
      cursorColor: cursorColor ?? AppColors.textPrimary,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final timedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: timedText,
        selection: TextSelection(
          baseOffset: timedText.length,
          extentOffset: timedText.length,
        ),
      );
    }

    return newValue;
  }
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains any spaces
    if (newValue.text.contains(' ')) {
      // If it does, return the old value
      return oldValue;
    }
    // Otherwise, return the new value
    return newValue;
  }
}
