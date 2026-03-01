import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/VIEW/COMPONENT/Shimmer/category_card_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.find<HomeController>();

  final logoutController = Get.find<LogoutController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    );
    return GetBuilder(
      init: DrawerService(),
      builder: (drawerService) {
        return Obx(() {
          return CustomBlurryModal(
            isLoading: logoutController.isLoading.value,
            circleSize: 30,
            child: CustomStatusBar(
              child: Scaffold(
                key: drawerService.scaffoldKey,
                backgroundColor: ColorsApp.backgroundColor,
                drawer: Drawer(
                  width: 270.w,
                  backgroundColor: ColorsApp.backgroundColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  child: DrawerContent(),
                ),
                onDrawerChanged: drawerService.onDrawerChanged,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppCardWithDrawer(drawerService: drawerService),
                        GestureDetector(
                          onTap: () => Get.to(
                            () => const TechnicalSupportScreen(),
                            transition: Transition.fadeIn,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                            child: Container(
                              height: 65.w,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                color: Colors.white,
                                border: Border.all(color: ColorsApp.secondaryBrownColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10.w,
                                children: [
                                  SvgPicture.asset(
                                    ImagesApp.chat,
                                    colorFilter: ColorFilter.mode(
                                      ColorsApp.primaryGreenColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  text(
                                    title: 'اسأل المهندس الزراعي',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BannerWidget(),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(title: 'الأقسام', fontSize: 22.sp, fontWeight: FontWeight.w700),
                              SizedBox(height: 15.h),

                              Obx(() {
                                if (homeController.isLoading.value) {
                                  return buildCategoryShimmer(homeController);
                                }

                                if (homeController.categories.isEmpty) {
                                  return Center(
                                    child: text(title: 'لا توجد فئات', fontSize: 14.sp),
                                  );
                                }

                                return StaggeredGrid.count(
                                  crossAxisCount: 10,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                  children: List.generate(homeController.categories.length, (
                                    index,
                                  ) {
                                    final category = homeController.categories[index];
                                    return StaggeredGridTile.count(
                                      crossAxisCellCount: homeController.getCrossAxisCount(index),
                                      mainAxisCellCount: 5,
                                      child: CategoryCard(
                                        image: category.image,
                                        categoryId: category.id,
                                        categoryName: category.name,
                                      ),
                                    );
                                  }),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
                floatingActionButton: getToken().isNotEmpty ? SupportButton() : null,
              ),
            ),
          );
        });
      },
    );
  }
}
