import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import '../../../PlansScreenForAllApp/Pages/mainPage.dart';

class FirstOpeningPageWidget extends StatelessWidget {
  const FirstOpeningPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController1 = TextEditingController();
    final TextEditingController textFieldController2 = TextEditingController();

    Future<void> addToDatabase() async {
      String text1 = textFieldController1.text;
      String text2 = textFieldController2.text;
      plansName = text1;

      final plans = {
        "name": text1,
        "price": text2,
      };

      await FirebaseFirestore.instance
          .collection("Plans")
          .doc(text1)
          .set(plans);

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

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Birikim Hesabı Oluşturun",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: textFieldController1,
            decoration: InputDecoration(
              labelText: 'Birikim hesabınıza isim veriniz',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            controller: textFieldController2,
            decoration: InputDecoration(
              labelText: 'Biriktirmek istediğiniz miktarı giriniz',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
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
                onPressed: addToDatabase,
                child: Text(
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
}
