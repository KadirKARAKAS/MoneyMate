import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../../PlansScreenForAllApp/Pages/mainPage.dart';
import 'package:moneymate/Utils/constants.dart';

class FirstOpeningPageWidget extends StatefulWidget {
  const FirstOpeningPageWidget({Key? key}) : super(key: key);

  @override
  State<FirstOpeningPageWidget> createState() => _FirstOpeningPageWidgetState();
}

class _FirstOpeningPageWidgetState extends State<FirstOpeningPageWidget> {
  final ImagePicker imagePicker = ImagePicker();
  String imagePath = '';
  final ImagePicker picker = ImagePicker();
  String selectedImagePath = '';
  final TextEditingController textFieldController1 = TextEditingController();
  final TextEditingController textFieldController2 = TextEditingController();
  late TextEditingController textEditingControllerTest;
  @override
  void initState() {
    super.initState();
    textEditingControllerTest = TextEditingController();
  }

  @override
  void dispose() {
    textFieldController1.dispose();
    textFieldController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Birikim Hesabı Oluşturun",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: textFieldController1,
            decoration: const InputDecoration(
              labelText: 'Birikim hesabınıza isim veriniz',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            controller: textFieldController2,
            decoration: const InputDecoration(
              labelText: 'Biriktirmek istediğiniz miktarı giriniz',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          addPlansImage(),
          Text(
            "Biriktirmek istediğiniz ürünün resmini seçin",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () async {
                if (imagePath.isNotEmpty) {
                  print('start');
                  List<String> imagePathList = imagePath.split('/');
                  await FirebaseStorage.instance
                      .ref('PlansImage')
                      .child(imagePathList[imagePathList.length - 1])
                      .putFile(File(imagePath));
                  print('Resim Eklendi');
                  final imageUrl = await FirebaseStorage.instance
                      .ref(
                          'PlansImage/${imagePathList[imagePathList.length - 1]}')
                      .getDownloadURL();
                  imageURLL = imageUrl;
                  print('İmage urlllllllllllllll:::$imageURLL');
                } else {
                  print('Resim seçilmedi.');
                }

                addToDatabase();
              },
              child: Container(
                width: size.width / 3,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff4BAE4F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Oluştur",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapCreateAccount() async {
    if (textFieldController1.text.isNotEmpty &&
        textFieldController2.text.isNotEmpty) {
      addToDatabase();
    } else {}
  }

  Future<void> addToDatabase() async {
    String text1 = textFieldController1.text;
    String text2 = textFieldController2.text;
    plansName = text1;
    imageURLL = imageURLL;

    final plans = {
      "name": text1,
      "price": text2,
      "imageUrl": imageURLL,
    };

    await FirebaseFirestore.instance.collection("Plans").doc(text1).set(plans);

    textFieldController1.clear();
    textFieldController2.clear();

    await FirebaseFirestore.instance
        .collection("Plans")
        .doc(text1)
        .get()
        .then((doc) {
      Map<String, dynamic> xMap = doc.data() as Map<String, dynamic>;
      getdataList.addAll([xMap]);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPageScreen(),
      ),
    );
  }

  Widget topBorWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        width: size.width,
        height: 80,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 40, bottom: 40),
        child: Center(
          child: Text(
            "",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 32,
                ))),
      ),
    ]);
  }

  ClipOval addPlansImage() {
    return ClipOval(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onTapFunction();
        },
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.transparent,
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
