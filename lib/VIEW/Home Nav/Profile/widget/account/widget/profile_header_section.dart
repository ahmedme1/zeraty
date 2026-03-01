import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileHeaderSection extends StatelessWidget {
  final ProfileController controller;

  const ProfileHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ProfileHeaderTop(controller: controller),
            SizedBox(height: 14.h),
            ProfileTabBar(controller: controller),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
