import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ImageService {
  /// pick image from source
  ///  set true if you want to pick from gallery
  ///  set false if you want to pick from camera
  static Future<Uint8List?> _pickAndConvertImageToBytes(bool isGallery) async {
    final picker = ImagePicker();
    ImageSource source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
      return null;
    }
    final Uint8List bytes = await pickedFile.readAsBytes();
    return bytes;
  }

  /// convert bytes to image widget
  Widget byteToImageWidget(Uint8List bytes,
      [double? width, double? height, BoxFit? fit]) {
    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text("Error Loading Image");
      },
    );
  }

  static Future<Uint8List?> pickImage(BuildContext context) async {
    Uint8List? result;
    await showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "pick images",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          result = await _pickAndConvertImageToBytes(false);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 10.w,
                            ),
                            Text(
                              "From Camera",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          result = await _pickAndConvertImageToBytes(true);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              size: 10.w,
                            ),
                            Text(
                              "From Gallery",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.w),
                ],
              ),
            ));

    return result;
  }
}
