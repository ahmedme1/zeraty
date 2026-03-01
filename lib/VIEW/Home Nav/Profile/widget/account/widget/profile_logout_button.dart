import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ProfileLogoutButton extends StatelessWidget {
  final ProfileController controller;

  const ProfileLogoutButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.logout,
      child: Container(
        padding: EdgeInsets.all(9.w),
        decoration: BoxDecoration(
          color: ColorsApp.withOpacity(Colors.white, 0.15),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsApp.withOpacity(Colors.white, 0.2)),
        ),
        child: Icon(Icons.logout_rounded, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
