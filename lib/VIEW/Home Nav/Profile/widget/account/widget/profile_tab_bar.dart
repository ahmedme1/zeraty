import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileTabBar extends StatelessWidget {
  final ProfileController controller;

  const ProfileTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorsApp.withOpacity(Colors.white, 0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsApp.withOpacity(Colors.white, 0.2)),
      ),
      child: Row(
        children: [
          ProfileTabItem(
            icon: Icons.receipt_long_rounded,
            label: 'طلباتي',
            isActive: controller.selectedTabIndex == 1,
            onTap: () => controller.changeTab(1),
          ),
          ProfileTabItem(
            icon: Icons.manage_accounts_rounded,
            label: 'حسابي',
            isActive: controller.selectedTabIndex == 2,
            onTap: () => controller.changeTab(2),
          ),
        ],
      ),
    );
  }
}
