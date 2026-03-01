import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Color color;
  final Color textColor;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backButton = false,
    this.color = ColorsApp.primaryGreenColor,
    this.textColor = Colors.white,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: text(title: title, color: textColor, fontSize: 18.sp, fontWeight: FontWeight.bold),
      centerTitle: true,
      backgroundColor: color,
      surfaceTintColor: color,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: backButton
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomBackButton(
                icon: Icons.arrow_back,
                color: Colors.white,
                onTap: () => Get.back(),
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
