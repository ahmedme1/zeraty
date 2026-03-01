import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({
    super.key,
    required this.child,
    this.statusBarColor = Colors.white,
    this.iconsColor = Brightness.dark,
  });

  final Widget child;
  final Color statusBarColor;
  final Brightness iconsColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: iconsColor,

        systemNavigationBarColor: statusBarColor,
        systemNavigationBarIconBrightness: iconsColor,
      ),
      child: child,
    );
  }
}
