import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class AppCardWithDrawer extends StatelessWidget {
  const AppCardWithDrawer({super.key, required this.drawerService});
  final DrawerService drawerService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesApp.well),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48.r),
          bottomRight: Radius.circular(48.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48.r),
                  bottomRight: Radius.circular(48.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorsApp.withOpacity(Colors.black, 0.45),
                    ColorsApp.withOpacity(Colors.black, 0.15),
                    ColorsApp.withOpacity(Colors.black, 0.55),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: drawerService.openEnd,
                      child: Container(
                        height: 45.h,
                        width: 45.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorsApp.withOpacity(Colors.white, 0.2),
                        ),
                        child: SvgPicture.asset(ImagesApp.menu),
                      ),
                    ),
                    if (getToken().isNotEmpty)
                      // GestureDetector(
                      //   onTap: () => Get.to(() => CartScreen(), transition: Transition.fade),
                      //   behavior: HitTestBehavior.opaque,
                      //   child: Obx(() {
                      //     final count = Get.find<CartController>().itemCount;
                      //     return Stack(
                      //       clipBehavior: Clip.none,
                      //       children: [
                      //         Container(
                      //           height: 45.h,
                      //           width: 45.w,
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(16.r),
                      //             color: ColorsApp.applyOpacity(Colors.white, 0.2),
                      //           ),
                      //           child: SvgPicture.asset(ImagesApp.cart),
                      //         ),
                      //         if (count > 0)
                      //           Positioned(
                      //             top: -6.h,
                      //             left: -6.w,
                      //             child: Container(
                      //               constraints: BoxConstraints(minWidth: 22.w),
                      //               height: 22.h,
                      //               padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //               decoration: BoxDecoration(
                      //                 gradient: LinearGradient(
                      //                   colors: [
                      //                     ColorsApp.secondaryBrownColor,
                      //                     ColorsApp.primaryGreenColor,
                      //                   ],
                      //                   begin: Alignment.topLeft,
                      //                   end: Alignment.bottomRight,
                      //                 ),
                      //                 borderRadius: BorderRadius.circular(30.r),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: ColorsApp.applyOpacity(
                      //                       ColorsApp.secondaryBrownColor,
                      //                       0.5,
                      //                     ),
                      //                     blurRadius: 6,
                      //                     offset: const Offset(0, 2),
                      //                   ),
                      //                 ],
                      //               ),
                      //               alignment: Alignment.center,
                      //               child: text(
                      //                 title: count > 99 ? '99+' : count.toString(),
                      //                 color: Colors.white,
                      //                 fontSize: 10.sp,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ),
                      //       ],
                      //     );
                      //   }),
                      // ),
                      GestureDetector(
                        onTap: () =>
                            Get.to(() => NotificationScreen(), transition: Transition.fade),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 45.h,
                          width: 45.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: ColorsApp.withOpacity(Colors.white, 0.2),
                          ),
                          child: SvgPicture.asset(
                            ImagesApp.notification,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Column(
                  spacing: 10.h,
                  children: [
                    text(
                      title: 'زراعتي',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    text(
                      title: 'منتجات وخدمات زراعية',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
