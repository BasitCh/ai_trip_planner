import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

Future<void> baseBottomSheet({
  required BuildContext context,
  required String title,
  bool userRootNavigator = false,
  required Widget content, // Make sure content is passed
  EdgeInsets? padding,
  double? bottomSheetHeight,
  VoidCallback? onClose,
  Widget? bottomWidget,
  Widget? trailingWidget,
}) {
  return showModalBottomSheet(
    isScrollControlled: true, // ✅ Ensures the bottom sheet resizes properly
    useRootNavigator: userRootNavigator,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: AppColors.transparent,
    context: context,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(ctx).viewInsets.bottom, // ✅ Adjusts for keyboard
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight:
                bottomSheetHeight ?? context.height * .85, // ✅ Increase height
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ✅ Allows dynamic height change
            children: [
              // Title and Close Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StandardText.subtitle2(
                      title,
                      fontSize: 24.sp,
                      color: AppColors.black,
                      fontWeight: AppFontWeight.semiBold,
                      letterSpacing: -2,
                      fontFamily: FontFamily.saira,
                    ),
                    trailingWidget ?? InkWell(
                      onTap: () {
                        if (onClose != null) {
                          onClose();
                        } else {
                          Navigator.pop(ctx);
                        }
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.interfaceGrey2,
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.darkPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Content Section
              Flexible(
                // ✅ Allows resizing
                child: SingleChildScrollView(
                  child: content,
                ),
              ),

              // Bottom Button
              if (bottomWidget != null) bottomWidget,
            ],
          ),
        ),
      );
    },
  );
}

Future<void> baseBottomSheetEmpty({
  required BuildContext context,
  required Widget content,
  bool? isDismissible,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: AppColors.transparent,
    context: context,
    isDismissible: isDismissible ?? true,
    builder: (ctx) => Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 20.h,
      ),
      height: ctx.height * .9,
      child: content,
    ),
  );
}

Future<void> noNavBarBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool isWhiteBackground = false,
  Widget? trailingWidget,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: isDismissible,
    useRootNavigator: useRootNavigator,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor:
        !isWhiteBackground ? AppColors.transparent : AppColors.white,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            50.verticalSpace,
            // Assets.icons.icArrowModal.svg(),
            10.verticalSpace,
            Stack(
              children: [
                Container(
                    width: context.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                    ),
                    child: builder(context)),
                if (trailingWidget != null)
                  Positioned(
                    top: 24.h,
                    right: 20.h,
                    child: trailingWidget,
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
