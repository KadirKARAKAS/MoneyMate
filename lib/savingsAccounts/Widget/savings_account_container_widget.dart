import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/models/savings_account.dart';

class SavingsAccountContainerWidget extends StatelessWidget {
  const SavingsAccountContainerWidget(
      {super.key, required this.containerText, required this.onTap});
  final String containerText;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: size.width,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(width: 0.4),
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xfff5f5f5),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2, color: Colors.black26, offset: Offset(0, 1))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  containerText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
          ),
        ),
      ),
    );
  }
}

class SavingsAccountListItemWidget extends StatelessWidget {
  const SavingsAccountListItemWidget(
      {super.key, required this.savingsAccount, required this.onTap});
  final SavingsAccount savingsAccount;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          // width: size.width,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(width: 0.4),
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xfff5f5f5),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2, color: Colors.black26, offset: Offset(0, 1))
              ]),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Hero(
                tag: savingsAccount.docId,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: CachedNetworkImage(
                      imageUrl: savingsAccount.photoURL,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    savingsAccount.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
