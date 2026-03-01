import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  const ImageSourceBottomSheet({
    super.key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: _buildOption(
                    icon: Icons.camera_alt,
                    title: 'الكاميرا'.tr,
                    color: ColorsApp.buttonsColor,
                    onTap: onCameraSelected,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildOption(
                    icon: Icons.photo_library,
                    title: 'المعرض'.tr,
                    color: Colors.purple,
                    onTap: onGallerySelected,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, ColorsApp.withOpacity(color, 0.8)]),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.withOpacity(color, 0.3),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40.sp),
            SizedBox(height: 8.h),
            text(title: title, fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
