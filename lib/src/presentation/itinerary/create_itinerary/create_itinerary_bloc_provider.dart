import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/mood_cubit.dart';

class CreateItineraryBlocProvider extends StatelessWidget {
  const CreateItineraryBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoodCubit>(create: (_) => MoodCubit(context),child: child,);
  }
}
