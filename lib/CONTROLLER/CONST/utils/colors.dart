import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ColorsApp {
  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │                            Apply Opacity                                  │
  // └───────────────────────────────────────────────────────────────────────────┘

  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity.clamp(0.0, 1.0));
  }

  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │                          Default App Color                                │
  // └───────────────────────────────────────────────────────────────────────────┘
  static const Color primaryGreenColor = Color(0xff2E7D32);

  static const Color secondaryBrownColor = Color(0xff8D6E63);
  static const Color accentYellowColor = Color(0xffFBC02D);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  static const Color textLightColor = Color(0xffFBE5D8);
  static const Color buttonsColor = Color(0xffDFB6B2);
  static const Color textDarkColor = Color(0xff364153);
  static const Color titleColor = Color(0xff333333);
}
