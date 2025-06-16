import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/domain/favorites/collection.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class CollectionItemCard extends StatelessWidget {
  final Collection collection;
  final Function() onTap;
  final bool? isSelected;

  const CollectionItemCard({
    super.key,
    required this.collection,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center, // Centers the icon
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                      color: isSelected!
                          ? AppColors.primary
                          : AppColors.progressLight,
                      width: 3.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    child: CustomImageView(
                      imagePath: collection.image,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                ),

                // ✅ Centered Heart Icon
                if (isSelected!)
                  Opacity(
                      opacity: 0.9, child: Assets.icons.icOrangeFavorite.svg()),
              ],
            ),
            Gap(10.h),
            Text("${collection.itineraries.length} favourites",
                style: subTitleStyle?.copyWith(
                    fontSize: 16,
                    letterSpacing: 0,
                    color: AppColors.progressDark)),
            Container(
              transform: Matrix4.translationValues(0, -5, 0),
              child: Text(collection.name, style: titleXSmallBlackInter),
            ),
          ],
        ));
  }
}
