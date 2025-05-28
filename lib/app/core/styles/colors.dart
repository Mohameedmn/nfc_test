// ignore_for_file: library_prefixes, prefer_const_constructors

// ignore: unused_import
import 'package:flutter/material.dart' as materialColors;
import 'package:flutter/material.dart';

class MainColors {
  static Color? backgroundColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.backgroundColor;
  static Color? shadowColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.shadowColor;
  static Color? textColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.textColor;
  static Color? inputColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.inputColor;
  static Color? disableColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.disableColor;
  static Color? infoColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.infoColor;
  static Color? errorColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.errorColor;
  static Color? successColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.successColor;
  static Color? warningColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.warningColor;

  //static String? fullLogo(BuildContext context) => Theme.of(context).extension<ColorsStyles>()?.fullLogo;
  //static String? iconLogo(BuildContext context) => Theme.of(context).extension<ColorsStyles>()?.iconLogo;
  // static const Color primaryColor =  Color(0xFF25683C);
  static const Color primaryColor = Color(0xFF3CAB4F); //3B3FB6 //3A3FB5//0ee3ab
  static const Color whiteColor = Colors.white;
  static const Color backgroundColorBottomSheet = Color(0xFF002506);

  static const Color blackColor = Color(0xFF444444);
  //FF444444 //292D32
  static const Color logoutcotor = Color.fromARGB(27, 102, 0, 115);
  static const Color drawwerbottom = Color(0xff0a260073);
  static const Color blackDark = Color.fromARGB(255, 0, 0, 0);
  // ignore: constant_identifier_names
  static const Color TextInputComponentColor = Color(0xFF292D32);
  // 001D01
  static const Color splashcolor = Color(0xFF001D01);
  static const Color lightGreen = Color(0xFF13A17D);
  static const Color darkGreen = Color(0xFF0C5542);
  // static const Color darkGreeneeeee =
  //      Color(0xFF292D32); //0C5542 //1B453F
  static const Color transparentColor = Colors.transparent;
  static const Color seconColor = Color(0xFFFFB41A);
  static const Color pendingColor = Color(0xFFF06B33);
  // #F06B33
  static Color backgroundColoGrey = Color(0xFF292D32).withOpacity(0.12);
  static const Color redColor = Color(0xFFFF5151);
  static const Color indicatorcolor = Color(0xFFF06B33);
  static const orangeGradientColor = LinearGradient(
    colors: [Color(0xFFFDBD28), Color(0xFFF06B33)], //0xFFFF950B//0xFF3A3FB5
    // colors: [Color(0xFF25683C), Color(0xFF25683C)],
    // 292D32
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const primaryGradientColor = LinearGradient(
    colors: [Color(0xFF8BB746), Color(0xFF3CAB4F)], //0xFFFF950B//0xFF3A3FB5
    // colors: [Color(0xFF25683C), Color(0xFF25683C)],
    // 292D32
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const bottomGradientColor = LinearGradient(
    colors: [Color(0xFF8BB746), Color(0xFF3CAB4F)], //0xFFFF950B//0xFF3A3FB5
    // colors: [Color(0xFF25683C), Color(0xFF25683C)],
    // 292D32
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class LightColors {
  // static const Color backgroundColor =
  //      Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF7F7F7);
  //F7F7F7 //FFFBFAFF//FBFAFF
  static const Color shadowColor = Color(0xFFEAEAEA);
  static const Color textColor = Color(0xFF444444);
  static const Color inputColor = Color(0xFFF6F6F6);
  static const Color disableColor = Color(0xFF9E9E9E);
  static const Color infoColor = Color(0xFF008FFF);
  static const Color errorColor = Color(0xFFFF5151);
  static const Color warningColor = Color(0xFF3B3FB6);
  static const Color successColor = Color(0xFF02BD4D);

  // static const String fullLogo = LogosAssetsConstants.lightFullLogo;
  // static const String iconLogo = LogosAssetsConstants.lightIconLogo;
}

class DarkColors {
  static const Color backgroundColor = Color(0xFF181A21);
  static const Color shadowColor = Color(0xFF0A0A0A);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color inputColor = Color(0xFF1E222B);
  static const Color disableColor = Color(0xFFA39E9E);
  static const Color infoColor = Color(0xFF45ADFF);
  static const Color errorColor = Color(0xFFFF7575);
  static const Color warningColor = Color.fromARGB(255, 253, 35, 35);
  static const Color successColor = Color(0xFF02BD4D);
  //static const String fullLogo = LogosAssetsConstants.darkFullLogo;
  //static const String iconLogo = LogosAssetsConstants.darkIconLogo;
}

@immutable
class ColorsStyles extends ThemeExtension<ColorsStyles> {
  const ColorsStyles({
    required this.backgroundColor,
    required this.disableColor,
    required this.textColor,
    required this.infoColor,
    required this.errorColor,
    required this.warningColor,
    required this.successColor,
    required this.shadowColor,
    required this.inputColor,
    // required this.fullLogo,
    // required this.iconLogo,
  });

  final Color? backgroundColor;
  final Color? disableColor;
  final Color? textColor;
  final Color? infoColor;
  final Color? errorColor;
  final Color? warningColor;
  final Color? successColor;
  final Color? shadowColor;
  final Color? inputColor;
  // final String? fullLogo;
  //final String? iconLogo;

  @override
  ColorsStyles copyWith({
    Color? backgroundColor,
    Color? disableColor,
    Color? textColor,
    Color? infoColor,
    Color? warningColor,
    Color? errorColor,
    Color? successColor,
    Color? shadowColor,
    Color? inputColor,
    Color? unSelectedColor,
    Color? cardColor,
    String? logo,
  }) {
    return ColorsStyles(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disableColor: disableColor ?? this.disableColor,
      textColor: textColor ?? this.textColor,
      infoColor: infoColor ?? this.infoColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      inputColor: inputColor ?? this.inputColor,
      shadowColor: shadowColor ?? this.shadowColor,
      //fullLogo: fullLogo ?? fullLogo,
      // iconLogo: iconLogo ?? iconLogo,
    );
  }

  @override
  ColorsStyles lerp(ThemeExtension<ColorsStyles>? other, double t) {
    if (other is! ColorsStyles) {
      return this;
    }
    return ColorsStyles(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      disableColor: Color.lerp(disableColor, other.disableColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      infoColor: Color.lerp(infoColor, other.infoColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      inputColor: Color.lerp(inputColor, other.inputColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      //fullLogo: fullLogo,
      //iconLogo: iconLogo,
    );
  }
}
