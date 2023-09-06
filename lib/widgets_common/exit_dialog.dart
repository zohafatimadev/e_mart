import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      "Confirm".text.fontFamily(bold).size(18).color(Colors.black).make(),
      const Divider(),
      20.heightBox,
      "Are you sure you want to exit ?"
          .text
          .size(16)
          .color(Colors.black)
          .make(),
      20.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
              color: redColor,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "yes"),
          ourButton(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No"),
        ],
      ),
    ],
  ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make());
}
