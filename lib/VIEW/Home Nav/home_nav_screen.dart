import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class HomeNavScreen extends StatelessWidget {
  HomeNavScreen({super.key});
  final DrawerService drawerService = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeNavController>(
      init: HomeNavController(),
      builder: (homeNavController) {
        return CustomStatusBar(
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            body: homeNavController.screenList[homeNavController.selectedIndex],
            bottomNavigationBar: Container(
              color: ColorsApp.backgroundColor,
              margin: EdgeInsets.only(bottom: 5.h),
              child: SafeArea(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 93.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.backgroundColor,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsApp.withOpacity(Colors.black, 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(homeNavController.items.length, (index) {
                      final item = homeNavController.items[index];
                      final isSelected = homeNavController.selectedIndex == index;

                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(25.r),
                        onTap: () => homeNavController.toggleSelectedIndex(index),
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: ColorsApp.backgroundColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedScale(
                                duration: Duration(milliseconds: 200),
                                scale: isSelected ? 1.1 : 1,
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? LinearGradient(
                                            colors: [
                                              ColorsApp.primaryGreenColor,
                                              ColorsApp.withOpacity(
                                                ColorsApp.primaryGreenColor,
                                                0.9,
                                              ),
                                            ],
                                          )
                                        : null,
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: ColorsApp.withOpacity(
                                                ColorsApp.primaryGreenColor,
                                                0.3,
                                              ),
                                              blurRadius: 6.r,
                                              spreadRadius: -4.r,
                                              offset: const Offset(0, 4),
                                            ),
                                            BoxShadow(
                                              color: ColorsApp.withOpacity(
                                                ColorsApp.primaryGreenColor,
                                                0.3,
                                              ),
                                              blurRadius: 15.r,
                                              spreadRadius: -3.r,
                                              offset: const Offset(0, 10),
                                            ),
                                          ]
                                        : null,
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: isSelected
                                        ? ColorsApp.primaryGreenColor
                                        : Colors.transparent,
                                  ),
                                  child: Obx(() {
                                    final count = Get.find<CartController>().itemCount;

                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        SvgPicture.asset(
                                          item['icon']!,
                                          height: 20.h,
                                          width: 20.w,
                                          colorFilter: ColorFilter.mode(
                                            isSelected
                                                ? Colors.white
                                                : ColorsApp.secondaryBrownColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        if (index == 3 && count > 0)
                                          Positioned(
                                            top: isSelected ? -15.h : -6.h,
                                            left: isSelected ? -10.h : -6.h,
                                            child: Container(
                                              constraints: BoxConstraints(minWidth: 18.w),
                                              height: 18.h,
                                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    ColorsApp.secondaryBrownColor,
                                                    ColorsApp.primaryGreenColor,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : ColorsApp.primaryGreenColor,
                                                  width: 1.5,
                                                ),
                                                borderRadius: BorderRadius.circular(20.r),
                                              ),
                                              alignment: Alignment.center,
                                              child: text(
                                                title: count > 99 ? '99+' : count.toString(),
                                                color: Colors.white,
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  }),
                                ),
                              ),

                              SizedBox(height: 5.h),
                              text(
                                title: item['label']!,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? ColorsApp.primaryGreenColor
                                    : ColorsApp.secondaryBrownColor,
                                fontSize: isSelected ? 13.sp : 12.sp,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
// import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
// import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

// class HomeNavScreen extends StatelessWidget {
//   HomeNavScreen({super.key});
//   final DrawerService drawerService = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeNavController>(
//       init: HomeNavController(),
//       builder: (homeNavController) {
//         return CustomStatusBar(
//           child: SafeArea(
//             child: Scaffold(
//               backgroundColor: Colors.white,
//               extendBody: true,
//               body: homeNavController.screenList[homeNavController.selectedIndex],
//               bottomNavigationBar: Obx(() {
//                 return CustomBottomNavBar(
//                   selectedIndex: homeNavController.selectedIndex,
//                   items: homeNavController.items,
//                   onTap: homeNavController.toggleSelectedIndex,
//                   badges: {3: Get.find<CartController>().itemCount},
//                 );
//               }),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
