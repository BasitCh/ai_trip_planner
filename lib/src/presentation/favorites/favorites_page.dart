import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'widgets/collection_grid_view.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CollectionGridView(
      onCollectionTap: ({collection, needToRemove}) {
        context.pushNamed(NavigationPath.collectionItinerariesUri,
            extra: collection);
      },
    );
  }
}
