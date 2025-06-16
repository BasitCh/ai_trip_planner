import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/favorites/favorites_cubit/favorites_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({required this.itinerary, required this.onPressed, super.key});
  final TravelItinerary? itinerary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        bool isLiked = state.favoriteIds.contains(itinerary?.id);
        return IconButton(
          onPressed: onPressed,
          icon: isLiked
              ? Assets.icons.filledBlackHeart.svg()
              : Icon(Icons.favorite_outline_outlined),
          iconSize: 25,
        );
      },
    );
  }
}
