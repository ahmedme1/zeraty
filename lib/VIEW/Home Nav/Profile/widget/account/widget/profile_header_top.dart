import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileHeaderTop extends StatelessWidget {
  final ProfileController controller;

  const ProfileHeaderTop({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          ProfileAvatarWidget(controller: controller),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: controller.name.isEmpty ? 'مرحباً بك' : controller.name,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF69F0AE),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    text(
                      title: controller.phone.isEmpty ? '' : controller.phone,
                      color: ColorsApp.withOpacity(Colors.white, 0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ProfileLogoutButton(controller: controller),
        ],
      ),
    );
  }
}
