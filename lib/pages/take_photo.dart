import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto extends StatefulWidget {
  final int productId;
  const TakePhoto({super.key, required this.productId});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic pickImageError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _takePhoto(200, 200, 100),
                child: _imageFile != null
                    ? Image.file(
                        File(_imageFile!.path),
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Color(0xFFC4C4C4)),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Subir foto'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _takePhoto(
      double? maxWidth, double? maxHeight, int? quality) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      setState(() {
        _imageFile = pickedFile;
        _upload();
      });
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  void _upload() {
    //uploadImage(_imageFile!.path.toString(), widget.productId);
  }
}