part of 'modal_bloc.dart';

@immutable
abstract class ModalEvent {
  const ModalEvent();
}

class ShowGeneralDialogEvent extends ModalEvent {
  final Widget widget;

  const ShowGeneralDialogEvent(this.widget);
}

class ShowBaseBottomSheetEvent extends ModalEvent {
  final String title;
  final Widget widget;
  final Widget? bottomWidget;
  final Widget? trailingWidget;
  final double? bottomSheetHeight;
  final VoidCallback? onClose;

  const ShowBaseBottomSheetEvent(
    this.title,
    this.widget, {
    this.bottomWidget,
    this.trailingWidget,
    this.bottomSheetHeight,
    this.onClose,
  });
}

class ShowNoNavBarBottomSheetEvent extends ModalEvent {
  final Widget widget;
  final Widget? trailingWidget;

  const ShowNoNavBarBottomSheetEvent(this.widget, [this.trailingWidget]);
}

class ModalPopped extends ModalEvent {}
