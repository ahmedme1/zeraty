import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBlurryModal(
        isLoading: registerController.isLoading.value,
        circleSize: 30,
        child: CustomStatusBar(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: CustomBackgroundApp(
              child: SafeArea(
                top: false,
                child: Builder(
                  builder: (context) {
                    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Image.asset(ImagesApp.logo, fit: BoxFit.cover, height: 80.h, width: 80.w),
                        text(
                          title: 'إنشاء حساب جديد',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        text(
                          title: 'انضم إلى عائلة زراعتي',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                              top: 20.h,
                              right: 16.w,
                              left: 16.w,
                              bottom: keyboardHeight > 0 ? keyboardHeight : 16.h,
                            ),
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
                                    title: 'الإسم',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.secondaryBrownColor,
                                  ),
                                  CustomTitleTextField(
                                    controller: registerController.nameController,
                                    keyboardType: TextInputType.name,
                                    hint: 'أدخل اسمك الكامل',
                                    borderRadius: 16.r,
                                    prefixIcon: SvgPicture.asset(
                                      ImagesApp.phone,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  text(
                                    title: 'رقم الهاتف',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.secondaryBrownColor,
                                  ),
                                  CustomTitleTextField(
                                    controller: registerController.phoneController,
                                    keyboardType: TextInputType.phone,
                                    hint: 'xxxxxxxx',
                                    borderRadius: 16.r,
                                    prefixIcon: SvgPicture.asset(
                                      ImagesApp.phone,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    inputFormatters: egyptPhoneInputFormatters,
                                  ),
                                  Row(
                                    children: [
                                      Obx(() {
                                        return DropdownField(
                                          label: 'المحافظة',
                                          hint: 'اختر المحافظة',
                                          svgAsset: ImagesApp.location,
                                          value: registerController.selectedGovernorate.value,
                                          items: registerController.governorates,
                                          onChanged: registerController.onGovernorateChanged,
                                        );
                                      }),
                                      SizedBox(width: 14.w),
                                      Obx(() {
                                        final enabled =
                                            (registerController.selectedGovernorate.value !=
                                                null) &&
                                            registerController.centers.isNotEmpty;
                                        return DropdownField(
                                          label: 'المركز',
                                          hint: enabled ? 'اختر المركز' : 'اختر محافظة أولاً',
                                          svgAsset: ImagesApp.location,
                                          value: enabled
                                              ? registerController.selectedCenter.value
                                              : null,
                                          items: enabled
                                              ? registerController.centers
                                              : <String>[].obs,
                                          onChanged: enabled
                                              ? registerController.onCenterChanged
                                              : null,
                                          disabled: !enabled,
                                        );
                                      }),
                                    ],
                                  ),
                                  text(
                                    title: 'كلمة المرور',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.secondaryBrownColor,
                                  ),
                                  CustomTitleTextField(
                                    controller: registerController.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    hint: '••••••••',
                                    borderRadius: 16.r,
                                    obscureText: registerController.obscureText.value,
                                    prefixIcon: SvgPicture.asset(
                                      ImagesApp.password,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: registerController.toggleShowPassword,
                                      icon: Icon(
                                        registerController.obscureText.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  text(
                                    title: 'تأكيد كلمة المرور',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.secondaryBrownColor,
                                  ),
                                  CustomTitleTextField(
                                    controller: registerController.passwordConfirmationController,
                                    keyboardType: TextInputType.visiblePassword,
                                    hint: '••••••••',
                                    borderRadius: 16.r,
                                    obscureText: registerController.obscureText2.value,
                                    prefixIcon: SvgPicture.asset(
                                      ImagesApp.password,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: registerController.toggleShowPasswordConfirmation,
                                      icon: Icon(
                                        registerController.obscureText2.value
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
                                    title: 'إنشاء الحساب',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    onTap: registerController.validationDateAndRegister,
                                  ),

                                  SizedBox(height: 10.h),
                                  HaveAccount(isLogin: false),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
