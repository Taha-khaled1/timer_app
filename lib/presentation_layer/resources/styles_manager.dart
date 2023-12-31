import 'package:flutter/material.dart';

import 'font_manager.dart';

class MangeStyles {
  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight,
      height: 1.40,
      letterSpacing: 0.20,
    );
  }

// regular style

  TextStyle getRegularStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

// medium style

  TextStyle getMediumStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

// medium style

  TextStyle getLightStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

// bold style

  TextStyle getBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }

// semibold style

  TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  TextStyle getTitel({double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }
}
