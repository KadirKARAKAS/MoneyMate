import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlansAddPhoto extends StatefulWidget {
  const PlansAddPhoto({super.key});

  @override
  State<PlansAddPhoto> createState() => _PlansAddPhotoState();
}

class _PlansAddPhotoState extends State<PlansAddPhoto> {
  final ImagePicker imagePicker = ImagePicker();
  String imagePath = '';
  final ImagePicker picker = ImagePicker();
  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addPlansImage(),
          SizedBox(height: 10),
          InkWell(
            onTap: () async {
              if (imagePath.isNotEmpty) {
                print('start');
                List<String> imagePathList = imagePath.split('/');
                await FirebaseStorage.instance
                    .ref('PlansImage')
                    .child(imagePathList[imagePathList.length - 1])
                    .putFile(File(imagePath));
                print('Resim Eklendi');
              } else {
                print('Resim seçilmedi.');
              }
            },
            child: Container(
              width: 100,
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(
                  "Storage Ekle",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  ClipOval addPlansImage() {
    return ClipOval(
      child: InkWell(
        onTap: () {
          onTapFunction();
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: imagePath == ''
              ? const Icon(
                  Icons.image,
                  size: 55,
                )
              : Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  onTapFunction() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath = image.path;
      setState(() {});
    }
  }
}
