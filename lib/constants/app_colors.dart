import 'package:flutter/material.dart';

class AppColors {
  // ---------- App Colors ----------

  static const bgColor = Color(0xFF1E1E1E);

  static const white = Color(0xFFFFFFFF);

  static const black1 = Color(0xFF000000);
  static const black2 = Color(0xFF3C4043);

  static const grey1 = Color(0xFF1E1E1E);
  static const grey2 = Color(0xFF323232);
  static const grey3 = Color(0xFF474747);
  static const grey4 = Color(0xFF646464);
  static const grey5 = Color(0xFFA2A2A2);
  static const grey6 = Color(0xFF31343E);

  static const red1 = Color(0xFFEB4E62);
  static const red2 = Color(0xFFEC6A5E);

  static const green1 = Color(0xFF61D396);
  static const green2 = Color(0xFF79D27D);

  static const dark3 = Color(0xFF2A2A49);
  static const orange = Color(0xFFE39E1C);

  static const blue1 = Color(0xFF589DFF);
  static const blue2 = Color(0xFF628FFF);

  static const lime = Color(0xFFEFFD86);

  static const yellow = Color(0xFFEFFD86);

  static const goldBadgeColor = Color(0xFFFFE3AD);
  static const silverBadgeColor = Color(0xFFF0F0F0);
  static const bronzeBadgeColor = Color(0xFFFFD5B8);

  static const calenderGreyOutsideMonth = Color(0xFF494949);

  static final whiteOpacity10 = const Color(0xFFFFFFFF).withOpacity(0.1);
  static final whiteOpacity15 = const Color(0xFFFFFFFF).withOpacity(0.15);
  static final whiteOpacity20 = const Color(0xFFFFFFFF).withOpacity(0.2);
  static final whiteOpacity25 = const Color(0xFFFFFFFF).withOpacity(0.25);
  static final whiteOpacity40 = const Color(0xFFFFFFFF).withOpacity(0.4);
  static final whiteOpacity60 = const Color(0xFFFFFFFF).withOpacity(0.6);
  static final whiteOpacity70 = const Color(0xFFFFFFFF).withOpacity(0.7);

  static final grey4Opacity10 = const Color(0xFFC0C6DB).withOpacity(0.1);
  static final grey3Opacity50 = const Color(0xFF7E859F).withOpacity(0.5);
  static final grey2Opacity50 = const Color(0xFF323232).withOpacity(0.5);
  static final grey2Opacity30 = const Color(0xFF323232).withOpacity(0.3);
  static final grey5Opacity25 = const Color(0xFFA2A2A2).withOpacity(0.25);
  static final grey2Opacity25 = const Color(0xFF323232).withOpacity(0.25);

  static Color textFieldOuterBorder = const Color.fromARGB(255, 98, 143, 255);
  static Color countryCodeSelectorColor = const Color.fromARGB(255, 50, 50, 50);

  static const securityItem1 = Color(0xFFFCE7BA);
  static const securityItem2 = Color(0xFFFBC6C6);
  static const securityItem3 = Color(0xFFD8FFD5);
  static const securityItem4 = Color(0xFFE2EEFA);
  static const securityItem5 = Color(0xFFF9F4E1);

  // ---------- App Gradient Colors ----------

  static const LinearGradient postGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.grey4,
      AppColors.grey2,
    ],
  );

  static const LinearGradient calenderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9E86FD),
      Color(0XFF492E49),
    ],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF765BF3),
      Color(0xFF5E40EB),
    ],
  );

  static const SweepGradient primaryG = SweepGradient(
    colors: [
      Color(0xFF765BF3),
      Color(0xFF5E40EB),
    ],
    stops: [0.25, 1.0],
  );

  static const LinearGradient disabledGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.grey4,
      AppColors.grey2,
    ],
  );

  static const date1 = Color(0xFFFD8686);
  static const date2 = Color(0xFFFD869E);
  static const date3 = Color(0xFFFD86B6);
  static const date4 = Color(0xFFFD86CD);
  static const date5 = Color(0xFFFD86E5);
  static const date6 = Color(0xFFFD86FD);
  static const date7 = Color(0xFFE586FD);
  static const date8 = Color(0xFFCD86FD);
  static const date9 = Color(0xFFB686FD);
  static const date10 = Color(0xFF9E86FD);
  static const date11 = Color(0xFF8686FD);
  static const date12 = Color(0xFF869EFD);
  static const date13 = Color(0xFF86B6FD);
  static const date14 = Color(0xFF86CDFD);
  static const date15 = Color(0xFF86E5FD);
  static const date16 = Color(0xFF86FDFD);
  static const date17 = Color(0xFF86FDE5);
  static const date18 = Color(0xFF86FDCD);
  static const date19 = Color(0xFF86FDB6);
  static const date20 = Color(0xFF86FD9E);
  static const date21 = Color(0xFF86FD86);
  static const date22 = Color(0xFF9EFD86);
  static const date23 = Color(0xFFB6FD86);
  static const date24 = Color(0xFFCDFD86);
  static const date25 = Color(0xFFE5FD86);
  static const date26 = Color(0xFFFDFD86);
  static const date27 = Color(0xFFFDE586);
  static const date28 = Color(0xFFFDCD86);
  static const date29 = Color(0xFFFDB686);
  static const date30 = Color(0xFFFD9E86);
  static const date31 = Color(0xFFFD8686);

  static const audio1 = Color(0XFf492E2E);
  static const audio2 = Color(0XFF49342E);
  static const audio3 = Color(0XFF49392E);
  static const audio4 = Color(0XFf492E2E);
  static const audio5 = Color(0XFF49432E);
  static const audio6 = Color(0XFf49492E);
  static const audio7 = Color(0XFf43492E);
  static const audio8 = Color(0XFF3E492E);
  static const audio9 = Color(0XFF39492E);
  static const audio10 = Color(0XFF34492E);
  static const audio11 = Color(0XFF2E492E);
  static const audio12 = Color(0XFF2E4934);
  static const audio13 = Color(0XFF2E4939);
  static const audio14 = Color(0XFF2E493E);
  static const audio15 = Color(0XFF2E4943);
  static const audio16 = Color(0XFF2E4949);
  static const audio17 = Color(0XFF2E4349);
  static const audio18 = Color(0XFF2E3E49);
  static const audio19 = Color(0XFF2E3949);
  static const audio20 = Color(0XFF2E3449);
  static const audio21 = Color(0XFF2E2E49);
  static const audio22 = Color(0XFF342E49);
  static const audio23 = Color(0XFF392E49);
  static const audio24 = Color(0XFF3E2E49);
  static const audio25 = Color(0XFF432E49);
  static const audio26 = Color(0XFF492E49);
  static const audio27 = Color(0XFF492E43);
  static const audio28 = Color(0XFF492E3E);
  static const audio29 = Color(0XFF492E39);
  static const audio30 = Color(0XFF492E34);
  static const audio31 = Color(0XFF492E2E);
}
