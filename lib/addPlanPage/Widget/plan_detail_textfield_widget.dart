import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/Utils/firebase_manager.dart';
import 'package:moneymate/homePage/Page/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class PlanDetailTextFieldWidget extends StatefulWidget {
  const PlanDetailTextFieldWidget({super.key});

  @override
  State<PlanDetailTextFieldWidget> createState() =>
      _PlanDetailTextFieldWidgetState();
}

final ImagePicker picker = ImagePicker();
String selectedImagePath = '';
final TextEditingController accountNameController = TextEditingController();
final TextEditingController targetValueController = TextEditingController();

class _PlanDetailTextFieldWidgetState extends State<PlanDetailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        savingAccountdetailcontainer(size, "Savings account name",
            accountNameController, TextInputType.name),
        const SizedBox(height: 10),
        savingAccountdetailcontainer(size, "Target amount you want to save",
            targetValueController, TextInputType.number),
        const SizedBox(height: 50),
        addSavingAccountPhoto(context),
        const SizedBox(height: 20),
        saveContainerButton(),
      ],
    );
  }

  Row saveContainerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            await storageSave();
            await addToDatabase();
          },
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 0.5,
                      color: Colors.black26,
                      offset: Offset(-2, 2))
                ]),
            child: const Center(
                child: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),
          ),
        ),
      ],
    );
  }

  Container savingAccountdetailcontainer(Size size, String containerText,
      TextEditingController controllerr, TextInputType keyboard) {
    return Container(
      width: size.width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(width: 0.3, color: const Color(0xff979797)),
          boxShadow: const [
            BoxShadow(
                blurRadius: 1, color: Colors.black26, offset: Offset(-2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
              keyboardType: keyboard,
              controller: controllerr,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: containerText,
                  hintStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff979797)))),
        ),
      ),
    );
  }

  Widget addSavingAccountPhoto(BuildContext context) {
    return InkWell(
      onTap: () async {
        //BURAYI EN SON DÜZENLE isGranted BLOK PARANTEZLERİNİN İÇERİSİNE YAZ
        addPhotoFunction();
        var status = await Permission.storage.status;
        print(status);
        if (status.isDenied) {
          await Permission.storage.request().then((value) {
            if (value.isGranted) {}
          });
        } else if (status.isGranted) {
          addPhotoFunction();
          print('İzin önceden soruldu ve kullanıcı izni verdi');
        } else {
          openAppSettings();
          print('İzin önceden soruldu ve kullanıcı izni vermedi');
        }
      },
      child: Container(
        width: 220,
        height: 280,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurRadius: 2, color: Colors.black26, offset: Offset(-2, 2))
            ],
            borderRadius: BorderRadius.circular(41),
            color: Colors.white,
            border: Border.all(width: 0.5, color: const Color(0xff979797))),
        child: selectedImagePath == ""
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("assets/uploadimage.png"),
                        width: 55,
                        height: 55,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Add image to savings account",
                        style: const TextStyle(color: Color(0xff979797)),
                      ),
                    ],
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(41),
                child: Image.file(
                  File(selectedImagePath),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  addPhotoFunction() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath = image.path;
      setState(() {});
    }
  }

  storageSave() async {
    List<String> imagePathList = selectedImagePath.split('/');
    await FirebaseStorage.instance
        .ref('SaveAccountPhoto')
        .child(imagePathList[imagePathList.length - 1])
        .putFile(File(selectedImagePath));
    final imageUrl = await FirebaseStorage.instance
        .ref('SaveAccountPhoto/${imagePathList[imagePathList.length - 1]}')
        .getDownloadURL();
    imageURLL = imageUrl;
  }

  Future<void> addToDatabase() async {
    String accountName = accountNameController.text;
    String targetValue = targetValueController.text;

    final savingAccount = {
      "AccountName": accountName,
      "TargetValue": targetValue,
      "PetsPhotoURL": imageURLL,
      'createdTime': DateTime.now()
    };

    final docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .add(savingAccount);

    // Oluşturulan belgeye docID ekleme aşaması
    await docRef.update({'docId': docRef.id});
    accountNameController.clear();
    targetValueController.clear();
    selectedImagePath = "";
    await FBManager.updatePlanList();
    startingIndex = 0;

    // final userRef = FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("My Plans")
    //     .orderBy('createdTime', descending: true);

    // final querySnapshot = await userRef.get();
    // getdataList.clear();
    // querySnapshot.docs.forEach((doc) async {
    //   await FirebaseFirestore.instance
    //       .collection('Users')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection("My Plans")
    //       .doc(doc.id)
    //       .update({'docId': doc.id});
    //   getdataList.add(doc.data());
    // });
    Future.delayed(const Duration(milliseconds: 500), () {
      getdataList.isEmpty
          ? const AlertDialog(
              actions: [],
            )
          : setState(() {
              circleBool = false;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePagePlans(
                      docId: getdataList[startingIndex]["docId"],
                    ),
                  ));
            });
    });
  }
}
