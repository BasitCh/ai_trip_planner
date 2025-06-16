import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/blocs/upload/upload_state.dart';
import 'package:travel_hero/src/infrastructure/upload/upload_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class ImageUploadDialog extends StatelessWidget {
  const ImageUploadDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ValueListenableBuilder<UploadState>(
        valueListenable: uploadProgressNotifier,
        builder: (context, uploadState, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Uploading ${uploadState.currentImageIndex} of ${uploadState.totalImages} images'),
                Gap(10.h),
                CircularProgressIndicator(
                  value: uploadState.progress,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
