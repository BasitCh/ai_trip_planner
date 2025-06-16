
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class TripCardWithImages extends StatelessWidget {
  const TripCardWithImages({super.key, required this.activity});
  final Activity activity;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Image Section
        if (activity.images.isNotEmpty) ...[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12)
            ),
            child: activity.images.first is String
                ? CustomImageView(
                    imagePath: activity.images.first,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    activity.images.first,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Gap(12.h),
        ],
        // Thumbnail Images Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
              height: 80, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: activity.images.length,
                itemBuilder: (context, index) {
                  return buildThumbnail(activity.images[index]);
                },
              )),
        ),
      ],
    );
  }

  // Widget to create thumbnail images
  Widget buildThumbnail(dynamic imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl is String
            ? CustomImageView(
                imagePath: imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
            : Image.file(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
      ),
    );
  }
}
