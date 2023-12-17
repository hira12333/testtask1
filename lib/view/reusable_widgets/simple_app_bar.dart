import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/constants/color.dart';

AppBar simpleAppBar({
  Color? bgColor,
  bool? hasIcon,
  Color? backiconColor,
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    backgroundColor: bgColor ?? kTertiaryColor,
    leadingWidth: MediaQuery.of(context).size.width,
    //automaticallyImplyLeading: false,
    elevation: 0.0, // Remove the shadow
    titleSpacing: 0.0,
    toolbarHeight: 60,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            hasIcon == true
                ? SizedBox(
                    // width: 150, // Adjust the width to make the image bigger
                    height: 25,
                    // Adjust the height to make the image bigger
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: backiconColor ?? kBlackColor,
                        )),
                  )
                : SizedBox(),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(fontFamily: 'playfair', fontSize: 30),
            )
          ],
        ),
        Container(
          width: 35,
        )
      ],
    ),
  );
}
