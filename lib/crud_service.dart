import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PickedImage {
  final Uint8List bytes;
  final String url;

  PickedImage({required this.bytes, required this.url});
}

class CrudService {
  static const cloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
    defaultValue: 'a78gezpf',
  );
  static const uploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
    defaultValue: 'Cloudinary',
  );

  final CollectionReference items = FirebaseFirestore.instance.collection(
    'items',
  );
  final ImagePicker _picker = ImagePicker();

  Future<PickedImage?> pickImageForItem() async {
    if (cloudName.isEmpty || uploadPreset.isEmpty) {
      throw StateError('Cloudinary cloud name and upload preset are required.');
    }
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final bytes = await pickedFile.readAsBytes();
    final cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);
    final response = await cloudinary.uploadFile(
      kIsWeb
          ? CloudinaryFile.fromBytesData(
              bytes,
              identifier: pickedFile.name,
              resourceType: CloudinaryResourceType.Image,
            )
          : CloudinaryFile.fromFile(
              File(pickedFile.path).path,
              resourceType: CloudinaryResourceType.Image,
            ),
    );
    return PickedImage(bytes: bytes, url: response.secureUrl);
  }

  Future<void> addItemWithImage(
    String name,
    int quantity,
    String? imageUrl,
  ) async {
    // CREATE
    await items.add({
      'name': name,
      'quantity': quantity,
      'image_url': imageUrl,
      'favorite': false,
      'createdAt': Timestamp.now(),
    });
  }

  // READ
  Stream<QuerySnapshot> getItems() {
    return items.orderBy('createdAt', descending: true).snapshots();
  }

  // UPDATE
  Future<void> updateItem(
    String id,
    String name,
    int quantity, {
    String? imageUrl,
  }) {
    final updates = <String, dynamic>{'name': name, 'quantity': quantity};
    if (imageUrl != null) {
      updates['image_url'] = imageUrl;
    }
    return items.doc(id).update(updates);
  }

  // FAVORITES
  Future<void> setFavorite(String id, bool isFavorite) {
    return items.doc(id).update({'favorite': isFavorite});
  }

  // DELETE
  Future<void> deleteItem(String id) {
    return items.doc(id).delete();
  }
}
