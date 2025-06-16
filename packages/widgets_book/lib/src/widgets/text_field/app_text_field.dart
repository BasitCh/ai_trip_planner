import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_book/widgets_book.dart';

/// {@template app_text_field}
/// A text field component based on material [TextFormField] widget with a
/// fixed, left-aligned label text displayed above the text field.
/// {@endtemplate}
class AppTextField extends StatelessWidget {
  /// {@macro app_text_field}
  const AppTextField({
    super.key,
    this.initialValue,
    this.autoFillHints,
    this.controller,
    this.inputFormatters,
    this.autocorrect = true,
    this.readOnly = false,
    this.hintText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.maxLines,
    this.onTap,
    this.textStyle,
    this.labelText,
    this.obscureText = false,
    this.borderRadius,
    this.hintStyle,
    this.contentPadding,
    this.fillcolor,
    this.textInputAction,
    this.validator,
    this.textColor,
    this.bordersidecolor = const BorderSide(color: AppColors.textfieldBorder),
    this.focusedcolor = const BorderSide(color: AppColors.textfieldBorder),
  });
  // ignore: avoid_field_initializers_in_const_classes
  final Color? fillcolor;
  final Color? textColor;
// ignore: avoid_field_initializers_in_const_classes, type_annotate_public_apis
  final hovercolor = AppColors.textfieldFill;
  // ignore: avoid_field_initializers_in_const_classes
  final bordersidecolor;
  // ignore: avoid_field_initializers_in_const_classes
  final focusedcolor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  /// A value to initialize the field to.
  final String? initialValue;
  final int? maxLines;
  final double? borderRadius;
  final TextInputAction? textInputAction;

  /// List of auto fill hints.
  final Iterable<String>? autoFillHints;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether to enable autocorrect.
  /// Defaults to true.
  final bool autocorrect;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool readOnly;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text that appears below the field.
  final String? errorText;

  /// A widget that appears before the editable part of the text field.
  final Widget? prefix;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  final TextInputType? keyboardType;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// Called when the text field has been tapped.
  final VoidCallback? onTap;
  final String? labelText;
  final bool obscureText;
  final EdgeInsets? contentPadding;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: TextFormField(
            key: key,
            maxLines: maxLines ?? 1,
            obscureText: obscureText,
            initialValue: initialValue,
            controller: controller,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            readOnly: readOnly,
            autofillHints: autoFillHints,
            textInputAction: textInputAction,
            cursorColor: AppColors.darkAqua,
            validator: validator,
            style: textStyle??Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: textColor??AppColors.textfieldBorder,
                  fontFamily: FontFamily.saira,
                ),
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              hintStyle: hintStyle,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: prefix,
              errorStyle: theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 12.sp, color: AppColors.secondary),
              errorMaxLines: 2,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              label: StandardText.headline1(
                labelText ?? '',
                color: AppColors.textfieldBorder,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.inter,
                fontSize: 10,
              ),
              suffixIcon: suffix,
              fillColor: fillcolor ?? AppColors.textfieldFill,
              hoverColor: hovercolor,
              enabledBorder: OutlineInputBorder(
                borderSide: bordersidecolor,
                borderRadius: BorderRadius.circular(borderRadius ?? 25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: focusedcolor,
                borderRadius: BorderRadius.circular(borderRadius ?? 25),
              ),
              suffixIconConstraints: const BoxConstraints.tightFor(
                width: 32,
                height: 32,
              ),
              prefixIconConstraints: const BoxConstraints.tightFor(
                width: 48,
              ),
            ),
            onChanged: onChanged,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
