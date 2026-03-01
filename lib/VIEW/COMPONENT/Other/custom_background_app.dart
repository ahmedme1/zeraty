import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class CustomBackgroundApp extends StatelessWidget {
  const CustomBackgroundApp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesApp.background),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorsApp.withOpacity(Colors.black, 0.45),
                    ColorsApp.withOpacity(Colors.black, 0.15),
                    ColorsApp.withOpacity(Colors.black, 0.55),
                  ],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
