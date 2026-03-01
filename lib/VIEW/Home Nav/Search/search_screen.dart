import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllers>(
      init: SearchControllers(),
      builder: (controller) {
        return CustomStatusBar(
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            appBar: CustomAppBar(title: 'البحث عن المنتجات'),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SearchInputCard(controller: controller),
                  SizedBox(height: 16.h),
                  SearchMethodCard(controller: controller),
                  SizedBox(height: 16.h),
                  SearchCategoryCard(controller: controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchInputCard extends StatelessWidget {
  final SearchControllers controller;

  const SearchInputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(title: 'ابحث الآن', fontSize: 18.sp, fontWeight: FontWeight.bold),
          SizedBox(height: 12.h),
          CustomTitleTextField(
            controller: controller.searchTextController,
            hint: 'ابحث',
            keyboardType: TextInputType.text,
            borderColor: ColorsApp.primaryGreenColor,
            borderRadius: 16.r,
            borderWidth: 1.87.w,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            prefixIcon: const Icon(Icons.search),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => CustomButtonWithImage(
              width: double.infinity,
              height: 55.h,
              buttonColor: ColorsApp.primaryGreenColor,
              borderRadius: 16.r,
              title: controller.isLoading.value ? 'جاري البحث...' : 'ابحث',
              iconHeight: 24.h,
              fontSize: 18.sp,
              icon: ImagesApp.search,
              onTap: controller.isLoading.value ? () {} : () => controller.search(),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchMethodCard extends StatelessWidget {
  final SearchControllers controller;

  const SearchMethodCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(title: 'طريقة البحث', fontSize: 18.sp, fontWeight: FontWeight.bold),
          SizedBox(height: 12.h),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: text(
                title: 'اختر طريقة البحث',
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
              value: controller.selectedSearchMethod,
              items: controller.searchMethods.map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(
                        title: method,
                        color: controller.selectedSearchMethod == method
                            ? ColorsApp.accentYellowColor
                            : Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      if (controller.selectedSearchMethod == method)
                        Icon(Icons.check, color: Colors.red, size: 20.sp),
                    ],
                  ),
                );
              }).toList(),
              selectedItemBuilder: (context) {
                return controller.searchMethods.map((String method) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: text(
                      title: method,
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }).toList();
              },
              onChanged: (String? newValue) {
                controller.updateSearchMethod(newValue);
              },
              iconStyleData: IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 24.sp),
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade300),
                  color: ColorsApp.primaryGreenColor,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: ColorsApp.primaryGreenColor,
                ),
                scrollbarTheme: ScrollbarThemeData(
                  radius: Radius.circular(40.r),
                  thickness: WidgetStateProperty.all(6),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchCategoryCard extends StatelessWidget {
  final SearchControllers controller;

  const SearchCategoryCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SearchCategoryShimmer();
      }
      if (controller.categories.isEmpty) {
        return SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsApp.secondaryBrownColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(
              title: 'حدد فئة البحث',
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4.h),
            text(
              title: 'يمكنك اختيار أكثر من فئة',
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 12.h),
            ...controller.categories.map((category) {
              return CategoryCheckboxItem(controller: controller, category: category);
            }),
          ],
        ),
      );
    });
  }
}

class CategoryCheckboxItem extends StatelessWidget {
  final SearchControllers controller;
  final CategoryModel category;

  const CategoryCheckboxItem({super.key, required this.controller, required this.category});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedCategoryIds.contains(category.id);

      return InkWell(
        onTap: () => controller.toggleCategory(category.id),
        child: Container(
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? ColorsApp.secondaryBrownColor : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  color: isSelected ? ColorsApp.secondaryBrownColor : Colors.white,
                ),
                child: isSelected ? Icon(Icons.check, color: Colors.white, size: 18.sp) : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: text(
                  title: category.name,
                  color: isSelected ? ColorsApp.secondaryBrownColor : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
