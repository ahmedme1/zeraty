import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class HomeNavController extends GetxController {
  List<Widget> screenList = [
    HomeScreen(),
    SearchScreen(),
    OrdersTab(withScaffold: true),
    CartScreen(),
    ProfileScreen(),
  ];
  List<Map<String, dynamic>> get items => [
    {'icon': ImagesApp.home, 'label': 'الرئيسية'.tr},
    {'icon': ImagesApp.search, 'label': 'البحث'.tr},
    {'icon': ImagesApp.order, 'label': 'طلباتي'.tr},
    {'icon': ImagesApp.cart, 'label': 'السلة'.tr},
    {'icon': ImagesApp.profile, 'label': 'الشخصي'.tr},
  ];

  int selectedIndex = 0;

  toggleSelectedIndex(int value) {
    selectedIndex = value;
    update();
  }
}
