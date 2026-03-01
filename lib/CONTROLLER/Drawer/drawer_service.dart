import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class DrawerService extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEndDrawerOpen = false;

  void openEnd() {
    scaffoldKey.currentState?.openDrawer();
    isEndDrawerOpen = true;
    update();
  }

  void closeEnd() {
    scaffoldKey.currentState?.closeDrawer();
    isEndDrawerOpen = false;
    update();
  }

  void onDrawerChanged(bool isOpened) {
    isEndDrawerOpen = isOpened;
    update();
  }
}
