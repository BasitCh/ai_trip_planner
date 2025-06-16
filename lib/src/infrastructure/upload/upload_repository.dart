// ignore_for_file: implementation_imports

import 'dart:io';
import 'package:fpdart/src/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:travel_hero/blocs/upload/upload_state.dart';
import 'package:travel_hero/src/domain/upload/i_upload_repository.dart';

ValueNotifier<UploadState> uploadProgressNotifier =
    ValueNotifier(UploadState());

class UploadRepository extends IUploadRepository {
  final FirebaseStorage firebaseStorage;

  UploadRepository({required this.firebaseStorage});

  @override
  Future<Either<Exception, List<String>>> uploadImages(
      {required String basePath, required List images}) async {
    List<String> downloadUrls = [];
    uploadProgressNotifier.value = UploadState(
      status: ImageUploadStatus.uploading,
      currentImageIndex: 0,
      totalImages: images.length,
    );

    try {
      for (int i = 0; i < images.length; i++) {
        final image = images[i];

        if (image is String && image.startsWith('http')) {
          // If the image is already a URL, add it directly
          downloadUrls.add(image);
          continue;
        } else if (image is File) {
          // It's a local file path, upload it
          final storageRef = firebaseStorage
              .ref()
              .child('$basePath/${DateTime.now().millisecondsSinceEpoch}');
          final data = await image.readAsBytes();

          final uploadTask = storageRef.putData(data);
          await for (var event in uploadTask.snapshotEvents) {
            final progress = (event.bytesTransferred / event.totalBytes) * 100;
            uploadProgressNotifier.value = UploadState(
              status: ImageUploadStatus.uploading,
              currentImageIndex: i + 1,
              progress: progress,
              totalImages: images.length,
            );
          }
          final snapshot = await uploadTask.whenComplete(() => null);
          final downloadUrl = await snapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      }
      uploadProgressNotifier.value = UploadState(
        status: ImageUploadStatus.success,
        currentImageIndex: images.length,
        totalImages: images.length,
      );

      return right(downloadUrls);
    } catch (e) {
      uploadProgressNotifier.value = UploadState(
        status: ImageUploadStatus.error,
        currentImageIndex: images.length,
        totalImages: images.length,
      );
      return left(Exception('Failed to upload images: $e'));
    }
  }
}
