import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class AppRatingBar extends StatelessWidget {
  const AppRatingBar({super.key,this.initialRating,this.minRating,this.ignoreGestures});
  final double? initialRating;
  final double? minRating;
  final bool? ignoreGestures;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating??5,
      minRating: minRating??1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: ignoreGestures??true,
      itemCount: 5,
      itemSize: 20,
      itemPadding: EdgeInsets.only(right: 5),
      itemBuilder: (context, _) => Assets.icons.icRatingStarFilled.svg(),
      onRatingUpdate: (rating) {
      },
    );
  }
}
