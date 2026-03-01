import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.categoryId,
    required this.categoryName,
  });
  final String image;
  final int categoryId;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => AllProductScreen(categoryId: categoryId, categoryName: categoryName),
          transition: Transition.fade,
        );
      },
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
        ),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, ColorsApp.withOpacity(Colors.black, 0.7)],
            ),
          ),
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(12.w),
          child: text(
            title: categoryName,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
