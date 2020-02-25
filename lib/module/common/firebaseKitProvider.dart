import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FirebaseKitProvider {
  Future<List<Face>> getFacesAsync(File imageFile) async {
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);

    return faces;
  }
}
