import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

ThemeData defaultTheme = ThemeData(
  scaffoldBackgroundColor: ColorsApp.backgroundColor,
  fontFamily: cairo,
  colorScheme: ColorScheme.fromSeed(
    // ignore: deprecated_member_use
    seedColor: ColorsApp.backgroundColor,
    // ignore: deprecated_member_use
    background: ColorsApp.backgroundColor,
  ),
  primaryColor: ColorsApp.backgroundColor,
  useMaterial3: true,
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(ColorsApp.backgroundColor)),
    textStyle: const TextStyle(color: Colors.white),
  ),
);
ThemeMode themeMode = ThemeMode.light;
