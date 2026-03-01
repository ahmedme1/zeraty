import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class BooksBackground extends StatelessWidget {
  const BooksBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * -0.01,
          left: MediaQuery.of(context).size.width * 0.1,
          child: BackdropFilter(
            filter: ImageFilter.blur(),
            child: ImageBackground(image: '', size: 100),
          ),
        ),

        child,
      ],
    );
  }
}

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.size, required this.image});

  final double size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: SvgPicture.asset(image, width: size, height: size),
    );
  }
}
