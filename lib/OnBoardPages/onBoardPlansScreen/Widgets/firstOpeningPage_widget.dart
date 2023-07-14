import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../PlansScreenForAllApp/Pages/mainPage.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstOpeningPageWidget extends StatefulWidget {
  const FirstOpeningPageWidget({Key? key}) : super(key: key);

  @override
  State<FirstOpeningPageWidget> createState() => _FirstOpeningPageWidgetState();
}

class _FirstOpeningPageWidgetState extends State<FirstOpeningPageWidget> {
  final ImagePicker picker = ImagePicker();
  String imagePath = '';
  File? selectedImagePath;

  final TextEditingController textFieldController1 = TextEditingController();
  final TextEditingController textFieldController2 = TextEditingController();

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
          uploadImageContainer(),
          const SizedBox(height: 10),
          const Text("Biriktirmek istediğiniz ürünün resmini seçiniz"),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: size.width / 3,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff4BAE4F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: onTapCreateAccount,
                child: const Text(
                  'Hesap oluştur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageContainer() {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: selectedImagePath != null
              ? DecorationImage(
                  image: FileImage(selectedImagePath!),
                  fit: BoxFit.cover,
                )
              : const DecorationImage(
                  image: AssetImage('assets/uploadimage.png'),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  void onTapFunction() async {
    if (await Permission.storage.request().isGranted) {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          selectedImagePath = File(image.path);
          imagePath = image.path;
        });
      }
    } else {}
  }

  void onTapCreateAccount() async {
    if (textFieldController1.text.isNotEmpty &&
        textFieldController2.text.isNotEmpty) {
      await storageOnTapFunction();
      addToDatabase();
    } else {
      SizedBox();
    }
  }

  Future<void> storageOnTapFunction() async {
    List<String> imagePathList = imagePath.split('/');
    File imageFile = File(imagePath);
    if (imageFile.absolute.existsSync()) {
      await FirebaseStorage.instance
          .ref('TestC')
          .child(imagePathList.last)
          .putFile(imageFile);
    } else {
      SizedBox();
    }
  }

  Future<void> addToDatabase() async {
    String text1 = textFieldController1.text;
    String text2 = textFieldController2.text;
    plansName = text1;

    final plans = {
      "name": text1,
      "price": text2,
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
}
