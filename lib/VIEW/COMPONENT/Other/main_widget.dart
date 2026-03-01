import 'package:zeraytee/CONTROLLER/Binding/app_bindings.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});
  final bool useCustomFeedback = false;

  @override
  Widget build(BuildContext context) {
    // MyLocalController controller = Get.put(MyLocalController(), permanent: true);
    return GetBuilder(
      init: MainController(),
      builder: (mainController) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          enableScaleText: () => false,
          builder: (_, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: GetMaterialApp(
                title: appName,
                initialBinding: AppBindings(),
                navigatorKey: MainController.navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: Locale('ar'),
                // translations: MyLocal(),
                themeMode: themeMode,
                darkTheme: defaultTheme,
                home: child!,
              ),
            );
          },
          child: SplashScreen(),
        );
      },
    );
  }
}
