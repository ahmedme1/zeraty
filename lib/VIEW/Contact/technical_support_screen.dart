import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TechnicalSupportController>(
      init: TechnicalSupportController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey.shade50,
            body: CustomScrollView(
              slivers: [
                TechnicalSupportAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      TechnicalSupportHeader(),
                      SizedBox(height: 24.h),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return TechnicalSupportShimmer();
                        }

                        if (controller.engineers.isEmpty) {
                          return TechnicalSupportEmpty();
                        }

                        return TechnicalSupportGrid(controller: controller);
                      }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TechnicalSupportAppBar extends StatelessWidget {
  const TechnicalSupportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: ColorsApp.primaryGreenColor,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: InkWell(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsApp.withOpacity(Colors.white, 0.9),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: ColorsApp.withOpacity(Colors.black, 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.arrow_back, color: ColorsApp.secondaryBrownColor, size: 18.sp),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 50.h,
                left: -30.w,
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(Colors.white, 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -50.h,
                right: -50.w,
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(Colors.white, 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.withOpacity(Colors.black, 0.1),
                            blurRadius: 10.r,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.support_agent,
                        color: ColorsApp.primaryGreenColor,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    text(
                      title: 'الدعم الفني',
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    text(
                      title: 'المهندسون الزراعيون',
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TechnicalSupportHeader extends StatelessWidget {
  const TechnicalSupportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
            ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.info_outline, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: 'نحن هنا لمساعدتك',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                text(
                  title: 'تواصل مع مهندسينا الزراعيين للحصول على الاستشارة المناسبة',
                  color: Colors.grey.shade700,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TechnicalSupportGrid extends StatelessWidget {
  final TechnicalSupportController controller;

  const TechnicalSupportGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: controller.engineers.map((engineer) {
          return EngineerCard(engineer: engineer, controller: controller);
        }).toList(),
      ),
    );
  }
}

class EngineerCard extends StatelessWidget {
  final TechnicalSupportModel engineer;
  final TechnicalSupportController controller;

  const EngineerCard({super.key, required this.engineer, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(Icons.person, color: Colors.white, size: 35.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, color: ColorsApp.primaryGreenColor, size: 14.sp),
                              SizedBox(width: 4.w),
                              text(
                                title: 'مهندس زراعي',
                                color: ColorsApp.primaryGreenColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    text(
                      title: engineer.name,
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone_android, color: Colors.grey.shade600, size: 14.sp),
                        SizedBox(width: 4.w),
                        text(
                          title: engineer.phone,
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.makePhoneCall(engineer.phone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primaryGreenColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                  ),
                  icon: Icon(Icons.phone, color: Colors.white, size: 20.sp),
                  label: text(
                    title: 'اتصال',
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.openWhatsApp(engineer.phone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff25D366),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                  ),
                  icon: Icon(Icons.chat, color: Colors.white, size: 20.sp),
                  label: text(
                    title: 'واتساب',
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TechnicalSupportEmpty extends StatelessWidget {
  const TechnicalSupportEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: Column(
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.support_agent, size: 60.sp, color: ColorsApp.primaryGreenColor),
            ),
            SizedBox(height: 24.h),
            text(
              title: 'لا يوجد مهندسون متاحون',
              color: ColorsApp.secondaryBrownColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            text(
              title: 'يرجى المحاولة لاحقاً',
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}

class TechnicalSupportShimmer extends StatelessWidget {
  const TechnicalSupportShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70.w,
                        height: 70.h,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: 100.w, height: 20.h, color: Colors.white),
                            SizedBox(height: 8.h),
                            Container(width: 150.w, height: 16.h, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
