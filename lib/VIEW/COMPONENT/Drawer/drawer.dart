import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/VIEW/Contact/delete_account_screen.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key});
  final userImage = getUserImage();

  @override
  Widget build(BuildContext context) {
    final drawerService = Get.find<DrawerService>();
    final logoutController = Get.find<LogoutController>();

    return GetBuilder(
      init: DrawerService(),
      builder: (_) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: getToken().isNotEmpty ? 200.h : 100.h,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: ColorsApp.primaryGreenColor,
                  // gradient: LinearGradient(
                  //   colors: [ColorsApp.secondaryBrownColor, ColorsApp.primaryGreenColor],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(
                          title: 'القائمة',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: drawerService.closeEnd,
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: ColorsApp.withOpacity(Colors.white, 0.2),
                            ),
                            child: SvgPicture.asset(ImagesApp.close),
                          ),
                        ),
                      ],
                    ),
                    if (getToken().isNotEmpty)
                      Container(
                        height: 80.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorsApp.withOpacity(Colors.white, 0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10.w,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsApp.withOpacity(Colors.white, 0.2),
                                image: DecorationImage(
                                  image: getUserImage().isEmpty
                                      ? AssetImage(ImagesApp.avatar)
                                      : NetworkImage(getUserImage()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: text(
                                title: getUserName(),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(
                init: HomeController(),
                builder: (drawerController) {
                  return Expanded(
                    child: Obx(() {
                      if (drawerController.isLoading.value) {
                        return ListView(
                          padding: EdgeInsets.all(15.w),
                          children: List.generate(8, (index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            );
                          }),
                        );
                      }

                      return ListView(
                        padding: EdgeInsets.all(15.w),
                        children: [
                          ...drawerController.categories.map((category) {
                            return DrawerItem(
                              title: category.name,
                              onTap: () => Get.to(
                                () => AllProductScreen(
                                  categoryId: category.id,
                                  categoryName: category.name,
                                ),
                                transition: Transition.fade,
                              ),
                            );
                          }),

                          if (drawerController.categories.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Divider(color: Colors.grey.shade300, thickness: 1),
                            ),

                          DrawerItem(
                            title: 'من نحن',
                            icon: ImagesApp.whosUs,
                            isCategory: false,
                            onTap: () => Get.to(() => AboutUsView(), transition: Transition.fade),
                          ),
                          DrawerItem(
                            title: 'شركاء النجاح',
                            icon: ImagesApp.partner,
                            isCategory: false,
                            onTap: () => Get.to(() => PartnerScreen(), transition: Transition.fade),
                          ),
                          DrawerItem(
                            title: 'الدعم الفني',
                            icon: ImagesApp.support,
                            isCategory: false,
                            onTap: () {
                              Get.to(
                                () => const TechnicalSupportScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                          ),
                          SizedBox(height: 15.h),
                          DrawerItem(
                            title: getToken().isNotEmpty ? 'تسجيل الخروج' : 'تسجيل الدخول',
                            icon: getToken().isNotEmpty
                                ? ImagesApp.uilSignout
                                : ImagesApp.uilSignin,
                            isCategory: false,
                            color: getToken().isNotEmpty ? Colors.red : Colors.green,
                            onTap: () {
                              if (getToken().isNotEmpty) {
                                drawerService.closeEnd();
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () => ConfirmationDialog.show(
                                    title: 'هل أنت متأكد ؟'.tr,
                                    subtitle: 'هل تريد تسجيل الخروج ؟'.tr,
                                    onConfirm: () => logoutController.logout(),
                                    onCancel: () => Get.back(),
                                  ),
                                );
                              } else {
                                Get.offAll(() => LoginScreen(), transition: Transition.fade);
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  drawerService.closeEnd,
                                );
                              }
                            },
                          ),
                          DrawerItem(
                            title: 'حذف الحساب',
                            icon: ImagesApp.deleteAccount,
                            isCategory: false,
                            onTap: () {
                              Get.to(
                                () => const DeleteAccountScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                          ),
                        ],
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    this.icon,
    this.isShowDivider = false,
    this.isCategory = true,
    this.color = ColorsApp.secondaryBrownColor,
    this.colorFilter,
    required this.onTap,
  });
  final String title;
  final String? icon;
  final bool isShowDivider;
  final bool isCategory;
  final Color color;
  final ColorFilter? colorFilter;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Column(
          spacing: 10.h,
          children: [
            Row(
              mainAxisAlignment: !isCategory
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              spacing: 10.w,
              children: [
                if (!isCategory)
                  Container(
                    height: 40.h,
                    width: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                    ),
                    child: SvgPicture.asset(
                      icon!,
                      fit: BoxFit.scaleDown,
                      height: 25.h,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),
                  ),
                text(
                  title: title,
                  color: color,
                  fontWeight: isCategory ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 18.sp,
                ),
                if (isCategory) Icon(Icons.arrow_forward_ios, color: color),
              ],
            ),
            if (isShowDivider) Divider(height: 30.h, color: Colors.grey.shade300, thickness: 1),
          ],
        ),
      ),
    );
  }
}
