import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    ;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          savingAccountdetailcontainer(size, "Savings account name",
              accountNameController, TextInputType.name),
          const SizedBox(height: 10),
          savingAccountdetailcontainer(size, "Target amount you want to save",
              targetValueController, TextInputType.number),
          const SizedBox(height: 50),
          addSavingAccountPhoto(),
        ],
      ),
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

  Widget addSavingAccountPhoto() {
    return Container(
      width: 190,
      height: 250,
      color: Colors.red,
    );
  }

  Widget petsImageContainerWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
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
        width: size.width / 2,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(41),
            color: const Color(0xffBFFCFF),
            border: Border.all(width: 0.5, color: const Color(0xff979797))),
        child: selectedImagePath == ""
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add your photo",
                    style: const TextStyle(color: Color(0xff979797)),
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
}
