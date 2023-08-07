import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

class HomePagePlansPhotoWidget extends StatelessWidget {
  const HomePagePlansPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          image: DecorationImage(
              image: NetworkImage(getdataList[startingIndex]["PetsPhotoURL"]),
              fit: BoxFit.cover)),
    );
  }
}
