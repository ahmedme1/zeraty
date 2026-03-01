import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class CachedImageWithProgress extends StatelessWidget {
  const CachedImageWithProgress({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const SpinKitFadingCircle(color: ColorsApp.secondaryBrownColor, size: 40),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
