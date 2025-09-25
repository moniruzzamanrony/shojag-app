import 'package:flutter/widgets.dart';

/// [AppColors] is a class that contains all the colors used in the app
abstract class AppColors {
  static const colorAppGreenDark = Color(0xff021C17);
  static const colorAppBlueDark = Color(0xff010832);
  static const colorAppBlue = Color(0xff041791);
  static const colorAppRed = Color(0xffed1c24);
  static const colorAppGreen = Color(0xff02b795);
  static const colorAppYellow = Color(0xffff875a);
  static const colorAppGrey = Color(0xff686868);
  static const colorAppTransparent = Color(0x00000000);

  static Color get colorPrimary => colorAppGreen;
  static const colorPrimaryDark = Color(0xFFEA2617);
  static const colorPrimaryLight = Color(0xFFFFB7B2);
  static const colorWhite = Color(0xFFFFFFFF);
  static const colorBlack = Color(0xFF000000);
  static const colorGrey = Color(0xFF7B7B7B);
  static const colorGreyDark = Color(0xFF575757);
  static const colorGrey2 = Color(0xFF9E9E9E);
  static const colorGreyLight = Color(0xFFBBBBBB);
  static const colorGreyExtraLight = Color(0xFFD9D9D9);
  static const scaffoldBackgroundColorPaleMint = Color(0xFFE0F2F1);
  static const scaffoldBackgroundColorPaleMintLight = Color(0xFFF6F9F9);
  static const scaffoldBackgroundColorPaleMintOpacity = Color(0x33E0F2F1);
  static const colorSecondary = Color(0xFF1D3F50);

  static const communityCardColor = Color(0xffe7f8f6);
  static const communityCardBorderColor = Color(0xff02b795);
  static const policeCardColor = Color(0xfff2f2ff);
  static const policeCardBorderColor = Color(0xff090364);
  static const ambulanceCardColor = Color(0xfff2f2ff);
  static const ambulanceCardBorderColor = Color(0xff090364);
  static const fireServiceCardColor = Color(0xfffdeaeb);
  static const fireServiceCardBorderColor = Color(0xffed1c24);

  // text colors
  static const defaultTextColorLight = Color(0xFF292829);
  static const defaultTextColorDark = Color(0xFFFEFEFE);
  static const colorOnBodyText = Color(0xFF222222);
  static const colorOnTitleText = Color(0xFF777777);
  static const colorOnLabelText = Color(0xFF696969);

  static const colorError = Color(0xffcb0101);
  static const colorBlack2 = Color(0xff021526);

  static const kListBackground = Color(0xFFF6F6F6);
  static const kNavBarBackground = Color(0xffF4F8FF);
  static const kColorGradiant1 = Color(0xFF00AB8E);
  static const kGradiantOnboarding = LinearGradient(
    colors: [kColorGradiant1, colorWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const kGradiantRegistration = LinearGradient(
    colors: [kColorGradiant1, colorWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const kColorGradiant2 = Color(0xFF71C3B2);
  static const kGradiantTutorialText = LinearGradient(
    colors: [kColorGradiant2, colorWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
