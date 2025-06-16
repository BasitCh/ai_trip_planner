import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class AppCameraDelegate extends ImagePickerCameraDelegate {
  @override
  Future<XFile?> takePhoto({
    ImagePickerCameraDelegateOptions options =
        const ImagePickerCameraDelegateOptions(),
  }) async {
    return _takeAPhoto(options.preferredCameraDevice);
  }

  @override
  Future<XFile?> takeVideo({
    ImagePickerCameraDelegateOptions options =
        const ImagePickerCameraDelegateOptions(),
  }) {
    throw UnimplementedError();
  }
}

void setUpCameraDelegate() {
  final instance = ImagePickerPlatform.instance;
  if (instance is CameraDelegatingImagePickerPlatform) {
    instance.cameraDelegate = AppCameraDelegate();
  }
}

Future<XFile?> _takeAPhoto(CameraDevice device) async => null;

typedef OnPickImageCallback = void Function(
  double? maxWidth,
  double? maxHeight,
  int? quality,
);
