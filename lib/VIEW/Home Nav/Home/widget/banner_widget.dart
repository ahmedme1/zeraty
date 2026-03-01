import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      init: BannerController(),
      builder: (bannerController) {
        return Obx(() {
          if (bannerController.isLoading.value) {
            return SizedBox(
              height: 140.h,
              child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (ctx, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: BannerShimmer(),
                  );
                },
                options: CarouselOptions(
                  height: 145.h,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                ),
              ),
            );
          }

          if (bannerController.banners.isEmpty) {
            return SizedBox.shrink();
          }

          return SizedBox(
            height: 140.h,
            child: CarouselSlider.builder(
              itemCount: bannerController.banners.length,
              itemBuilder: (ctx, index, realIndex) {
                return BannerCard(banner: bannerController.banners[index]);
              },
              options: CarouselOptions(
                height: 145.h,
                viewportFraction: 0.85,
                initialPage: 0,
                enableInfiniteScroll: bannerController.banners.length > 1,
                autoPlay: bannerController.banners.length > 1,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
        });
      },
    );
  }
}
