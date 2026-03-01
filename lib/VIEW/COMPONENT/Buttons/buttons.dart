import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height = 52,
    this.width = 150,
    this.fontSize = 14,
    this.borderRadius = 25,
    this.textColor = Colors.white,
    this.buttonColor = ColorsApp.primaryGreenColor,
    this.fontWeight = FontWeight.w500,
    this.borderColor,
    required this.title,
    required this.onTap,
  });
  final double height;
  final double width;
  final Color buttonColor;
  final String title;
  final Color textColor;
  final Color? borderColor;

  final double fontSize;
  final double borderRadius;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r.r),
          color: buttonColor,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: text(title: title, color: textColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}

class CustomButtonWithImage extends StatelessWidget {
  const CustomButtonWithImage({
    super.key,
    this.height = 40,
    this.width = 150,
    this.fontSize = 14,
    this.iconHeight = 15,
    this.borderRadius = 16,
    this.textColor = Colors.white,
    this.buttonColor = ColorsApp.secondaryBrownColor,
    this.icon = '',
    required this.title,
    required this.onTap,
  });
  final double height;
  final double width;
  final double iconHeight;
  final Color buttonColor;
  final String title;
  final String icon;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.h,
          children: [
            SvgPicture.asset(
              icon,
              height: iconHeight,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            text(title: title, color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.onTap,
    this.color = Colors.white,
    this.icon = Icons.arrow_back_ios,
  });
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Icon(icon, color: color),
    );
  }
}
