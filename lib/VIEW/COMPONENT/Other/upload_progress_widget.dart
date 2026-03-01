import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/utils/colors.dart';

class UploadProgressWidget extends StatelessWidget {
  const UploadProgressWidget({
    super.key,
    required this.progress,
    required this.percent,
    required this.valueColor,
  });
  final double progress;
  final String percent;
  final Color valueColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: CircularProgressIndicator(
            value: progress,
            color: ColorsApp.secondaryBrownColor,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          ),
        ),
        text(title: '$percent %', fontSize: 20.sp, fontWeight: FontWeight.bold, color: valueColor),
      ],
    );
  }
}
