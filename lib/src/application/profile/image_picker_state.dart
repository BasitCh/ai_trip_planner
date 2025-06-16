part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerImagePicked extends ImagePickerState {
  final File image;

  ImagePickerImagePicked(this.image);
}

class ImagePickerError extends ImagePickerState {
  final String error;

  ImagePickerError(this.error);
}

class ImagePickerCropped extends ImagePickerState {
  final File croppedImage;

  ImagePickerCropped(this.croppedImage);
}
