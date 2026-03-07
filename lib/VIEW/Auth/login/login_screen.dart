import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBlurryModal(
        isLoading: loginController.isLoading.value,
        circleSize: 30,
        child: CustomStatusBar(
          child: SafeArea(
            top: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: CustomBackgroundApp(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Image.asset(ImagesApp.logo, fit: BoxFit.cover, height: 80.h, width: 80.w),
                    text(
                      title: 'تسجيل الدخول',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.h),
                    text(
                      title: 'مرحباً بك في زراعتي',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w, bottom: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 10.h,
                            children: [
                              text(
                                title: 'رقم الهاتف',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorsApp.secondaryBrownColor,
                              ),
                              CustomTitleTextField(
                                controller: loginController.phoneController,
                                keyboardType: TextInputType.phone,
                                hint: 'xxxxxxxx',
                                borderRadius: 16.r,
                                prefixIcon: SvgPicture.asset(
                                  ImagesApp.phone,
                                  fit: BoxFit.scaleDown,
                                ),
                                // inputFormatters: egyptPhoneInputFormatters,
                              ),

                              text(
                                title: 'كلمة المرور',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorsApp.secondaryBrownColor,
                              ),
                              CustomTitleTextField(
                                controller: loginController.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                hint: '••••••••',
                                borderRadius: 16.r,
                                obscureText: loginController.obscureText.value,
                                prefixIcon: SvgPicture.asset(
                                  ImagesApp.password,
                                  fit: BoxFit.scaleDown,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: loginController.toggleShowPassword,
                                  icon: Icon(
                                    loginController.obscureText.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomButton(
                                height: 55.h,
                                width: double.infinity,
                                borderRadius: 16.r,
                                title: 'دخول',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                onTap: loginController.validationDateAndLogin,
                              ),
                              CustomButton(
                                height: 55.h,
                                width: double.infinity,
                                borderRadius: 16.r,
                                title: 'الاستمرار بدون تسجيل',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                buttonColor: ColorsApp.secondaryBrownColor,
                                onTap: () {
                                  Get.offAll(() => HomeNavScreen(), transition: Transition.fade);
                                  CacheHelper.saveData(key: guestSession, value: true);
                                },
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      height: 20.h,
                                      thickness: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: text(
                                      title: 'أو',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      height: 20.h,
                                      thickness: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              CustomButton(
                                height: 55.h,
                                width: double.infinity,
                                borderRadius: 16.r,
                                title: 'إنشاء حساب جديد',
                                fontSize: 18.sp,
                                textColor: ColorsApp.secondaryBrownColor,
                                fontWeight: FontWeight.w700,
                                buttonColor: Colors.white,
                                borderColor: ColorsApp.secondaryBrownColor,
                                onTap: () =>
                                    Get.to(() => RegisterScreen(), transition: Transition.fade),
                              ),
                              SizedBox(height: 10.h),
                              FotgetPasswordWidget(onTap: () {}),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
