import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:travel_hero/blocs/app_config/app_mode_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/request_itinerary/itinerary_request_cubit.dart';

class Mood {
  final String name;
  bool isSelected;

  Mood({required this.name, this.isSelected = false});
}

class MoodCubit extends Cubit<List<Mood>> {
  MoodCubit(BuildContext context)
      : super([]) {
    _loadSavedAppModes(context);  // 🔥 Load saved AppModes on initialization

    // Add listeners to update state when text changes
    nameController.addListener(_updateState);
    guestsController.addListener(_updateState);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();

  /// 🔥 Load saved AppModes from AppModeCubit and update state
  void _loadSavedAppModes(BuildContext context) {
    final appModeCubit = context.read<AppModeCubit>();
    final savedAppModes = appModeCubit.appModes;

    // Convert saved AppModes to Mood objects
    final loadedMoods = savedAppModes.map((appMode) =>
        Mood(name: appMode.name)
    ).toList();

    emit(loadedMoods); // 🔥 Emit the loaded moods to update the state
  }

  void selectMood(int index, BuildContext context,{bool isRequestMood = true}) {
    List<Mood> updatedMoods = List.from(state);

    // Deselect all moods first
    for (int i = 0; i < updatedMoods.length; i++) {
      updatedMoods[i].isSelected = i == index;
    }
    if(isRequestMood) {
      context.read<ItineraryRequestCubit>().updateSelectedMood(
          updatedMoods[index].name);
    }else{
      context.read<CreateItineraryCubit>().updateMood(
          updatedMoods[index].name);
    }
    emit(updatedMoods);
  }


  void setName(BuildContext context) {
    context.read<ItineraryRequestCubit>().updateName(nameController.text);
    emit(List.from(state)); // Emit updated state to trigger UI refresh
  }

  void setGuests(BuildContext context) {
    context.read<ItineraryRequestCubit>().updateGuest(guestsController.text);
    emit(List.from(state)); // Emit updated state to trigger UI refresh
  }

  bool isAllSet() {
    bool isMoodSelected = state.any((mood) => mood.isSelected);
    bool isNameProvided = nameController.text.trim().isNotEmpty;
    bool isGuestsProvided = guestsController.text.trim().isNotEmpty;
    return isMoodSelected && isNameProvided && isGuestsProvided;
  }
  bool isMoodSet() {
    bool isMoodSelected = state.any((mood) => mood.isSelected);
    return isMoodSelected;
  }

  void _updateState() {
    emit(List.from(state)); // This ensures UI rebuilds when input changes
  }

  @override
  Future<void> close() {
    nameController.dispose();
    guestsController.dispose();
    return super.close();
  }
}
