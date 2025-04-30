import 'dart:io';

class TransGcsImagesListModel {
  late int id;
  late String imageName;
  File? imageFile;

  TransGcsImagesListModel({
    required this.id,
    required this.imageFile,
    required this.imageName,
  });
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "image_name": imageName,
    };
  }

}