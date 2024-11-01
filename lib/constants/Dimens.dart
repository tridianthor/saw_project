import 'package:flutter/material.dart';

class Dimens{
  static const double buttonWidth = 300;
  static const double buttonHeight = 56;

  static const double buttonHeightSlim = 46;

  static const double fontSmall = 12;
  static const double fontMedium = 16;
  static const double fontLarge = 20;
  static const double fontExtraLarge = 24;

  static const double defaultRoundedRadius = 8;
  static const double buttonRoundedRadius = 10;

  static RoundedRectangleBorder buttonRoundedBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(buttonRoundedRadius),
    ),
  );
}