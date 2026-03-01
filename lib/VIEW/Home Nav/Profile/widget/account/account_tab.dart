import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class AccountTab extends StatelessWidget {
  final ProfileController controller;

  const AccountTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.user.value == null) {
        return const ProfileShimmer();
      }

      return CustomBlurryModal(
        isLoading: controller.isLoading.value,
        circleSize: 35,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              ProfileImagePicker(controller: controller),
              SizedBox(height: 24.h),
              const SectionTitle(title: 'معلومات شخصية'),
              SizedBox(height: 16.h),
              PersonalInfoFields(controller: controller),
              SizedBox(height: 32.h),
              ActionButtons(controller: controller),
              SizedBox(height: 16.h),
              DeleteAccountButton(controller: controller),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      );
    });
  }
}
