import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_machine_learning_kit/module/firebaseKitProvider.dart';
import 'package:flutter_firebase_machine_learning_kit/module/imagePickerProvider.dart';
import 'package:flutter_firebase_machine_learning_kit/ui/facePainter.dart';

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  File _imageFile;
  ui.Image _image;
  List<Face> _faces;

  bool isLoading = false;

  _getImageAndDetectFaces() async {
    setState(() {
      isLoading = true;
    });

    ImagePickerProvider imagePickerProvider = new ImagePickerProvider();
    FirebaseKitProvider firebaseKitProvider = new FirebaseKitProvider();

    var imageFile = await imagePickerProvider.getImage();
    if (imageFile == null) {
      setState(() {
        isLoading = false;
      });

      return;
    }

    var faces = await firebaseKitProvider.getFacesAsync(imageFile);

    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
      (value) => setState(() {
        _image = value;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (_imageFile == null)
              ? Center(child: Text('Nenhuma imagem selecionada'))
              : Center(
                  child: FittedBox(
                    child: SizedBox(
                      width: _image.width.toDouble(),
                      height: _image.height.toDouble(),
                      child: CustomPaint(
                        painter: FacePainter(_image, _faces),
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndDetectFaces,
        tooltip: 'Selecionar imagem',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
