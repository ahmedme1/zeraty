import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class CustomBlurryModal extends StatelessWidget {
  const CustomBlurryModal({
    super.key,
    required this.isLoading,
    required this.child,
    required this.circleSize,
    this.isProgress = false,
    this.progressWidget = const SizedBox(),
  });
  final Widget child;
  final bool isLoading;
  final double circleSize;
  final bool isProgress;
  final Widget progressWidget;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 4,
      progressIndicator: isProgress
          ? progressWidget
          : SpinKitFadingCircle(color: Colors.white, size: circleSize),
      dismissible: false,
      opacity: 0.4,
      color: ColorsApp.secondaryBrownColor,
      child: child,
    );
  }
}
