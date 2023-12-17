import 'package:flutter/material.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/imagePaths/assets.dart';

BoxDecoration circle(Color color) {
  return BoxDecoration(shape: BoxShape.circle, color: color);
}

BoxDecoration rounded(Color color) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
      border: Border.all(color: kGrey3Color));
}

BorderRadius radius = BorderRadius.circular(15);
TextStyle styles(double? size, FontWeight? weight, Color? color) {
  return TextStyle(
    fontFamily: 'poppins',
    fontSize: size ?? 12,
    color: color ?? kSecondaryColor,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle mystyle(double size, FontWeight? weight, Color? color) {
  return TextStyle(
    fontFamily: Assets.fontsPoppinsRegular,
    fontSize: size ?? 12,
    color: color ?? kBlackColor,
    fontWeight: weight,
    overflow: TextOverflow.ellipsis,
  );
}
