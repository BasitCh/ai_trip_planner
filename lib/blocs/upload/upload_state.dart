class UploadState {
  final ImageUploadStatus status;
  final int totalImages;
  final int currentImageIndex;
  final double progress;

  UploadState({
    this.status = ImageUploadStatus.initial,
    this.totalImages = 0,
    this.currentImageIndex = 0,
    this.progress = 0.0,
  });
}

enum ImageUploadStatus { initial, uploading, success, error }