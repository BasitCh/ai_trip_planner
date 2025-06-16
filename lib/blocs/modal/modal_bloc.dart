import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'modal_event.dart';
part 'modal_state.dart';

class ModalBloc extends Bloc<ModalEvent, ModalState> {
  ModalBloc() : super(ModalInitial()) {
    on<ShowGeneralDialogEvent>(_mapShowGeneralDialogEventToState);
    on<ShowBaseBottomSheetEvent>(_mapShowBaseBottomSheetEventState);
    on<ShowNoNavBarBottomSheetEvent>(_mapShowNoNavBarBottomSheetEventState);
    on<ModalPopped>(_mapModalPoppedToState);
  }

  _mapShowGeneralDialogEventToState(
      ShowGeneralDialogEvent event, Emitter<ModalState> emit) {
    emit(ShowGeneralDialog(event.widget));
  }

  _mapShowBaseBottomSheetEventState(
      ShowBaseBottomSheetEvent event, Emitter<ModalState> emit) {
    emit(ShowBaseBottomSheet(
      event.title,
      event.widget,
      bottomWidget: event.bottomWidget,
      trailingWidget: event.trailingWidget,
      bottomSheetHeight: event.bottomSheetHeight,
      onClose: event.onClose,
    ));
  }

  _mapShowNoNavBarBottomSheetEventState(
      ShowNoNavBarBottomSheetEvent event, Emitter<ModalState> emit) {
    emit(ShowNoNavBarBottomSheet(event.widget, event.trailingWidget));
  }

  _mapModalPoppedToState(ModalPopped event, Emitter<ModalState> emit) {
    emit(ModalInitial());
  }
}
