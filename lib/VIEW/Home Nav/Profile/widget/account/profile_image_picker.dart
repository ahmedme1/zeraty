import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileImagePicker extends StatelessWidget {
  final ProfileController controller;

  const ProfileImagePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedImage = controller.selectedImage.value;
      final networkImage = controller.user.value?.imageUrl;

      return Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsApp.primaryGreenColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: selectedImage != null
                    ? Image.file(selectedImage, fit: BoxFit.cover)
                    : networkImage != null && networkImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: networkImage,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => _defaultAvatar(),
                      )
                    : _defaultAvatar(),
              ),
            ),
            Positioned(
              bottom: -4.h,
              left: -4.w,
              child: GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorsApp.withOpacity(Colors.black, 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _defaultAvatar() {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(Icons.person, size: 50.sp, color: Colors.grey.shade400),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final ProfileController controller;

  const ActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          ActionButton(
            title: 'حفظ كل التغييرات',
            backgroundColor: ColorsApp.primaryGreenColor,
            textColor: Colors.white,
            onPressed: () => controller.saveChanges(),
          ),
          SizedBox(height: 12.h),
          ActionButton(
            title: 'تسجيل خروج',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
          elevation: 0,
        ),
        child: text(title: title, color: textColor, fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class DeleteAccountButton extends StatelessWidget {
  final ProfileController controller;

  const DeleteAccountButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: () => controller.deleteAccount(),
        child: text(
          title: 'حذف الحساب',
          color: ColorsApp.primaryGreenColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
