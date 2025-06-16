part of 'modal_bloc.dart';

@immutable
abstract class ModalState extends Equatable {
  const ModalState();
  @override
  List<Object?> get props => [];
}

class ModalInitial extends ModalState {}

class ShowGeneralDialog extends ModalState {
  final Widget widget;

  const ShowGeneralDialog(this.widget);

  @override
  List<Object?> get props => [widget];
}

class ShowBaseBottomSheet extends ModalState {
  final String title;
  final Widget widget;
  final Widget? bottomWidget;
  final Widget? trailingWidget;
  final double? bottomSheetHeight;
  final VoidCallback? onClose;

  const ShowBaseBottomSheet(this.title, this.widget, {this.bottomWidget, this.trailingWidget, this.bottomSheetHeight, this.onClose,});
}

class ShowNoNavBarBottomSheet extends ModalState {
  final Widget widget;
  final Widget? trailingWidget;

  const ShowNoNavBarBottomSheet(this.widget, [this.trailingWidget]);
}
