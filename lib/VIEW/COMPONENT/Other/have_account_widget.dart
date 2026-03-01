import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key, required this.isLogin, this.isRemember = false});
  final bool isLogin;
  final bool isRemember;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLogin) {
          Get.offAll(() => RegisterScreen());
        } else {
          Get.offAll(() => LoginScreen());
        }
      },
      child: Center(
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              title: isLogin
                  ? 'ليس لديك حساب ؟'.tr
                  : isRemember
                  ? 'تذكرت كلمة المرور؟'.tr
                  : 'لديك حساب بالفعل ؟'.tr,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            text(
              title: isLogin
                  ? 'سجّل الان!'.tr
                  : isRemember
                  ? 'تسجيل الدخول'.tr
                  : 'تسجيل الدخول'.tr,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
