import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ImageController extends GetxController {
  var isValidImage = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  String? lastImageUrl;

  Future<void> validateImage(String url) async {
    if (url == lastImageUrl) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final imageProvider = CachedNetworkImageProvider(url);
      final completer = Completer<bool>();
      final imageStream = imageProvider.resolve(const ImageConfiguration());

      final listener = ImageStreamListener(
        (info, _) {
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        },
        onError: (error, stackTrace) {
          if (!completer.isCompleted) {
            completer.complete(false);
            errorMessage.value = error.toString();
          }
        },
      );

      imageStream.addListener(listener);

      isValidImage.value = await completer.future;
      lastImageUrl = url;
      imageStream.removeListener(listener);
    } catch (e) {
      isValidImage.value = false;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
