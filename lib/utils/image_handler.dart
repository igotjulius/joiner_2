import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class PickedImages {
  List<XFile>? pickedImages;
  Future<String?> selectImages() async {
    pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages == null) return null;
    if (pickedImages!.length > 5)
      return 'You can only upload upto 5 images at most.';
    return null;
  }

  List<XFile>? getImages() {
    return pickedImages;
  }

  Future<List<MultipartFile>> getConvertedImages() async {
    var files = <MultipartFile>[];
    for (final file in pickedImages!) {
      final multipartFile = MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
        contentType: MediaType('application', 'octet-stream'),
      );
      files.add(multipartFile);
    }
    return files;
  }
}
