import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/Home%20Nav/Home/home_controller.dart';

Widget buildCategoryShimmer(HomeController controller) {
  return StaggeredGrid.count(
    crossAxisCount: 10,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: List.generate(6, (index) {
      return StaggeredGridTile.count(
        crossAxisCellCount: controller.getCrossAxisCount(index),
        mainAxisCellCount: 5,
        child: const CategoryCardShimmer(),
      );
    }),
  );
}

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      ),
    );
  }
}
