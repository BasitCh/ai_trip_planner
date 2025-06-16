import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void nextPage(PageController pageController) {
    if (state < 2) {
      final newPage = state + 1;
      pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      //pageController.jumpToPage(newPage);
      emit(newPage);
    }
  }

  void previousPage(PageController pageController) {
    if (state > 0) {
      final newPage = state - 1;
      pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(newPage);
    }
  }

  void goToPage(int page,PageController pageController) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(page);
  }
}
