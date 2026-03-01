import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return CustomStatusBar(
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            body: CheckLogin(
              child: Column(
                children: [
                  ProfileHeaderSection(controller: controller),
                  Expanded(child: controller.currentTabWidget()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
