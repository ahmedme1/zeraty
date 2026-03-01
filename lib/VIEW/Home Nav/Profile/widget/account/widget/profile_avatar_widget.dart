import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final ProfileController controller;

  const ProfileAvatarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final imageUrl = CacheHelper.getData(key: userImage) ?? '';
    return Container(
      width: 54.w,
      height: 54.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorsApp.withOpacity(Colors.white, 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.withOpacity(Colors.black, 0.2),
            blurRadius: 10.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFF2E7D32),
                  child: Icon(Icons.person_rounded, color: Colors.white, size: 28.sp),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFF2E7D32),
                  child: Icon(Icons.person_rounded, color: Colors.white, size: 28.sp),
                ),
              )
            : Container(
                color: const Color(0xFF1B5E20),
                child: Icon(Icons.person_rounded, color: Colors.white, size: 28.sp),
              ),
      ),
    );
  }
}
