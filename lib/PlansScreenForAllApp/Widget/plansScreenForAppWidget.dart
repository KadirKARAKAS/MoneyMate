import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

class PlansScreenForAppWidget extends StatefulWidget {
  PlansScreenForAppWidget({super.key});

  @override
  State<PlansScreenForAppWidget> createState() =>
      _PlansScreenForAppWidgetState();
}

class _PlansScreenForAppWidgetState extends State<PlansScreenForAppWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                //TOP BAR KISMI BURASI
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  Container(
                    child: Text(
                      getdataList[0]["name"],
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(onTap: () {}, child: Icon(Icons.settings)),
                ],
              ),
            ),
          ),
          plansimagecircle(context, 170, 170),
          plansbalancevalue(context),
          finaloperations(),
          incomefinalOperationsContainer(),
          expensefinalOperationsContainer(),
          incomefinalOperationsContainer(),
          expensefinalOperationsContainer(),
        ],
      ),
    );
  }

  Widget plansimagecircle(BuildContext context, double widthh, double heighht) {
    return Container(
      width: widthh,
      height: heighht,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999), color: Colors.red),
    );
  }

  Widget plansbalancevalue(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  expensealertdialog(context);
                },
                child: Icon(
                  Icons.remove_circle_outlined,
                  color: Colors.red,
                  size: 60,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  getdataList[0]["price"],
                  style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  "₺",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  incomealertdialog(context);
                },
                child: Icon(
                  Icons.add_circle_outlined,
                  color: Colors.green,
                  size: 60,
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
      ],
    );
  }

  Widget finaloperations() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 70),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                child: Text(
                  "Son işlemler",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.grey,
            size: 20,
          )
        ],
      ),
    );
  }

  Future incomealertdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text("Gelir Ekle"),
            actions: [
              TextField(
                controller: incomeTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Birikim hesabınıza para ekleyin',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        balance =
                            balance + int.parse(incomeTextController.text);
                      });
                      Navigator.pop(context);
                      incomeBalanceValue = incomeTextController.text;
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Ekle",
                        style: TextStyle(fontSize: 24),
                      )),
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(16),
                          color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }

  Future expensealertdialog(BuildContext context) {
    final TextEditingController expenseTextController = TextEditingController();
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text("Gider Ekle"),
            actions: [
              TextField(
                controller: expenseTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Birikim hesabınızdan para çekin',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        balance =
                            balance - int.parse(expenseTextController.text);
                      });
                      if (balance <= 0) {
                        balance = 0;
                      } else {
                        balance;
                      }
                      expenseBalanceValue = expenseTextController.text;
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Ekle",
                        style: TextStyle(fontSize: 24),
                      )),
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(16),
                          color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }

  Widget incomefinalOperationsContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              plansimagecircle(context, 80, 80),
              SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getdataList[0]["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Gelir Eklendi",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                incomeBalanceValue,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "₺",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget expensefinalOperationsContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              plansimagecircle(context, 80, 80),
              SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getdataList[0]["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Gider Eklendi",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                expenseBalanceValue,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "₺",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
