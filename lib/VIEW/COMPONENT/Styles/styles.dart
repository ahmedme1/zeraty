import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

Text text({
  required String title,
  required double fontSize,
  int? maxLines,
  FontWeight fontWeight = FontWeight.normal,
  TextDecoration decoration = TextDecoration.none,
  Color color = ColorsApp.primaryGreenColor,
  TextAlign? textAlign = TextAlign.center,
  FontStyle? fontStyle,
  TextOverflow? overflow = TextOverflow.visible,
  Color? backgroundColor,
  double? height,
  List<Shadow>? shadows,
}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: cairo,
      fontSize: fontSize,
      fontWeight: fontWeight,
      backgroundColor: backgroundColor,
      color: color,
      fontStyle: fontStyle,
      decoration: decoration,
      height: height,
      shadows: shadows,
    ),
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
  );
}

EdgeInsetsGeometry padding_15 = const EdgeInsets.all(15);
EdgeInsetsGeometry padding_10 = const EdgeInsets.all(10);
EdgeInsetsGeometry padding_20 = const EdgeInsets.all(20);

double bottomInsetsForAllStudentMaterial = 220.h;
double bottomInsetsForStudentScreen = 200.h;
double bottomInsetsForStudentCategory = 220.h;
double bottomInsetsForAllStudentMaterialTablet = 200.h;

bool isTablet(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth > 600;
}

bool isArabic() {
  var language = CacheHelper.getData(key: lang);
  return language == ar;
}

Future<bool> isEmulator() async {
  if (Platform.isAndroid) {
    return await isAndroidEmulator();
  } else if (Platform.isIOS) {
    return false;
  }
  return false;
}

Future<bool> isAndroidEmulator() async {
  try {
    final result = await Process.run('getprop', ['ro.kernel.qemu']);
    return result.stdout.trim() == '1';
  } catch (e) {
    return false;
  }
}

// Size designSize({required BuildContext context}) {
//   return Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
// }
