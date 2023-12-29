import 'package:image_picker/image_picker.dart';

class PickedImages {
  List<XFile> _pickedImages = [];
  XFile? _pickedImage;
  Future<String?> selectImages() async {
    _pickedImages = await ImagePicker().pickMultiImage();
    if (_pickedImages.length > 5)
      return 'You can only upload upto 5 images at most.';
    return null;
  }

  Future<void> selectImage() async {
    _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  XFile? getImage() {
    return _pickedImage;
  }

  List<XFile> getImages() {
    return _pickedImages;
  }
}
