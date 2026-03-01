import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20.h,
      children: [
        Image.asset(ImagesApp.logo, fit: BoxFit.cover, height: 150.h, width: 150.w),
        text(title: 'زراعتي', fontSize: 48.sp, fontWeight: FontWeight.w700, color: Colors.white),
        text(
          title: 'شريكك في النجاح الزراعي',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.w,
          children: List.generate(
            3,
            (e) => Container(
              height: 12.h,
              width: 12.w,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
