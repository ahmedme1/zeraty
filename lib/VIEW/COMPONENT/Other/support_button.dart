import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => TechnicalSupportView(), transition: Transition.upToDown),
      child: Container(
        height: 70.h,
        width: 70.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: ColorsApp.secondaryBrownColor),
        ),
        child: SvgPicture.asset(
          height: 50.h,
          ImagesApp.myLogo,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(ColorsApp.primaryGreenColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
