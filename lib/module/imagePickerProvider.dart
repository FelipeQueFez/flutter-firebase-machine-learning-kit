import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  Future<File> getImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }
}
