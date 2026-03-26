import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String subtitle;
  final double price;
  final bool isFavorite;
  final bool isInCart;
  final int stock;
  final VoidCallback onFav;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isFavorite,
    required this.isInCart,
    required this.stock,
    required this.onFav,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProductImage(image: image, isFavorite: isFavorite, onFav: onFav, stock: stock),
          Expanded(
            child: ProductContent(
              title: title,
              subtitle: subtitle,
              price: price,
              onAdd: onAdd,
              isInCart: isInCart,
              stock: stock,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String image;
  final bool isFavorite;
  final int stock;
  final VoidCallback onFav;

  const ProductImage({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.stock,
    required this.onFav,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: image.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  height: 120.h,
                  memCacheWidth: 400,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: stock > 0 ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: text(
              title: stock > 0 ? 'متوفر' : 'نفذ',
              color: Colors.white,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (getToken().isNotEmpty)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: InkWell(
              onTap: onFav,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsApp.withOpacity(Colors.black, 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey.shade400,
                  size: 18.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() => Container(
    width: double.infinity,
    height: 120.h,
    color: Colors.grey.shade100,
    child: Icon(Icons.image_outlined, size: 40.sp, color: Colors.grey.shade300),
  );
}

class ProductContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int stock;
  final bool isInCart;
  final VoidCallback onAdd;

  const ProductContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.stock,
    required this.isInCart,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            title: title,
            color: Colors.black87,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              text(
                title: price.toStringAsFixed(0),
                color: ColorsApp.primaryGreenColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 2.w),
              text(
                title: 'ج',
                color: ColorsApp.primaryGreenColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          if (getToken().isNotEmpty) ...[
            SizedBox(height: 8.h),
            AddToCartButton(onAdd: onAdd, isInCart: isInCart, stock: stock),
          ],
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onAdd;
  final bool isInCart;
  final int stock;

  const AddToCartButton({
    super.key,
    required this.onAdd,
    required this.isInCart,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = stock == 0;
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: ElevatedButton(
        onPressed: disabled ? null : onAdd,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? Colors.grey.shade300
              : isInCart
              ? Colors.green.shade600
              : ColorsApp.secondaryBrownColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              disabled
                  ? Icons.remove_shopping_cart_outlined
                  : isInCart
                  ? Icons.check
                  : Icons.add,
              size: 12.sp,
              color: disabled ? Colors.grey.shade500 : Colors.white,
            ),
            SizedBox(width: 6.w),
            text(
              title: disabled
                  ? 'نفذ المخزون'
                  : isInCart
                  ? 'في السلة'
                  : 'اضف إلى السلة',
              color: disabled ? Colors.grey.shade500 : Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
