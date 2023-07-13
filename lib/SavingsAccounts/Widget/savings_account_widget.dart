import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

class SavingsAccountPageWidget extends StatelessWidget {
  const SavingsAccountPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      topBorWidget(context),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 3),
          shrinkWrap: true,
          itemCount: getdataList.length,
          itemBuilder: (context, index) {
            return savingspageContainer(
                context, getdataList[index]["name"], () {});
          },
        ),
      ),
    ]);
  }

  Widget topBorWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        width: size.width,
        height: 80,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Center(
          child: Text(
            "Birikim Hesaplarım",
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
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 32,
                ))),
      ),
    ]);
  }

  Widget savingspageContainer(
      BuildContext context, String containerText, Function onTap) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          onTap();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Stack(children: [
          Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.5))),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: Text(
                        containerText,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 3),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          balance.toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        child: Text(
                          "/",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        child: Text(
                          getdataList[0]["price"],
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget listViewWidget() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: getdataList.length,
        itemBuilder: (context, index) {
          savingspageContainer(context, getdataList[index]["name"], () {});
          return null;
        },
      ),
    );
  }
}
