import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PersonalInfoFields extends StatelessWidget {
  final ProfileController controller;

  const PersonalInfoFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          InfoField(
            label: 'الاسم',
            controller: controller.nameController,
            icon: ImagesApp.name,
            hint: 'احمد ايمن',
          ),
          SizedBox(height: 12.h),
          InfoField(
            label: 'البريد الالكتروني',
            controller: controller.emailController,
            icon: ImagesApp.email,
            hint: 'example@xxxxx.com',
          ),
          SizedBox(height: 12.h),
          InfoField(
            label: 'الهاتف',
            controller: controller.phoneController,
            icon: ImagesApp.phone,
            hint: '01xxxxxxxxx',
          ),
          SizedBox(height: 12.h),
          InfoField(
            label: 'كود المهندس',
            controller: controller.engineerCodeController,
            icon: ImagesApp.name,
            isInfo: true,
            hint: '3xxxxxxx',
          ),
          SizedBox(height: 12.h),
          GetBuilder<ProfileController>(
            builder: (c) {
              return EgyptGovDropdown(
                label: 'المحافظة',
                hint: 'اختر المحافظة',
                svgAsset: ImagesApp.location,
                value: c.selectedGovernorate,
                items: c.governorates,
                onChanged: c.onGovernorateChanged,
              );
            },
          ),
          SizedBox(height: 12.h),
          GetBuilder<ProfileController>(
            builder: (c) {
              return EgyptGovDropdown(
                label: 'المركز',
                hint: 'اختر المركز',
                svgAsset: ImagesApp.home,
                value: c.selectedCenter,
                items: c.availableCenters,
                onChanged: c.availableCenters.isEmpty ? null : c.onCenterChanged,
              );
            },
          ),
          SizedBox(height: 12.h),
          InfoField(
            label: 'العنوان التفصيلي',
            controller: controller.addressController,
            icon: ImagesApp.home,
            hint: 'العنوان التفصيلي',
          ),
        ],
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool isInfo;
  final String icon;

  const InfoField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 5.w,
          children: [
            text(title: label, color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w700),
            if (isInfo) SvgPicture.asset(ImagesApp.info, fit: BoxFit.scaleDown),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTitleTextField(
          controller: controller,
          keyboardType: TextInputType.text,
          hint: hint,
          borderColor: Colors.grey.shade300,
          prefixIcon: SvgPicture.asset(icon, fit: BoxFit.scaleDown),
        ),
      ],
    );
  }
}
