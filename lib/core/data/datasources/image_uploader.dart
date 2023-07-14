import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService {
  static const String _bookingDirName = 'booking';

  static Future<String> uploadImageOnline(
      String bookingId, Uint8List image) async {
    final String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference bookingReference = referenceRoot.child(_bookingDirName);
    Reference referenceDirectory = bookingReference.child(bookingId);
    Reference referenceImageToUpload = referenceDirectory.child(uniqueFileName);
    await referenceImageToUpload.putData(image);
    return await referenceImageToUpload.getDownloadURL();
  }

  static Future<void> deleteAllBookingImages(String bookingId) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference bookingReference = referenceRoot.child(_bookingDirName);
    ListResult docList = await bookingReference.child(bookingId).listAll();
    List<Reference> allImages = docList.items;
    for (int i = 0; i < allImages.length; i++) {
      await allImages[i].delete();
    }
  }
}
