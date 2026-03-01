import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(() {
      return CustomBlurryModal(
        isLoading: controller.isLoading.value,
        circleSize: 35,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            appBar: CustomAppBar(title: 'إتمام الطلب', backButton: true),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    OrderSummary(),
                    SizedBox(height: 16.h),
                    ShippingInfo(
                      nameController: controller.nameController,
                      phoneController: controller.phoneController,
                      stateController: controller.stateController,
                      addressController: controller.addressController,
                      notesController: controller.notesController,
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: PlaceOrderButton(formKey: _formKey),
          ),
        ),
      );
    });
  }
}

class PlaceOrderButton extends StatelessWidget {
  PlaceOrderButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsApp.backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        child: Obx(
          () => SizedBox(
            height: 56.h,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        _showConfirmationDialog(controller);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.primaryGreenColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                elevation: 0,
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        text(
                          title: 'تأكيد الطلب',
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(CartController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 40.sp),
            ),
            SizedBox(height: 20.h),
            text(
              title: 'تأكيد الطلب',
              color: ColorsApp.secondaryBrownColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 12.h),
            text(
              title: 'هل أنت متأكد من إتمام الطلب؟',
              color: Colors.grey.shade700,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    title: 'المجموع: ',
                    color: Colors.grey.shade700,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  text(
                    title: '${controller.total.toStringAsFixed(0)} ج',
                    color: ColorsApp.primaryGreenColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: text(
              title: 'إلغاء',
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.createOrder(
                name: controller.nameController.text,
                phone: controller.phoneController.text,
                address: controller.addressController.text,
                state: controller.stateController.text,
                notes: controller.notesController.text.isEmpty
                    ? null
                    : controller.notesController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.primaryGreenColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: text(
              title: 'تأكيد',
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key});
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              text(
                title: 'ملخص الطلب',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Column(
              children: [
                ...controller.cartItems.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: ColorsApp.primaryGreenColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: text(
                                  title: '${item.product.name} (×${item.quantity})',
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        text(
                          title: '${item.subtotal.toStringAsFixed(0)} ج',
                          color: ColorsApp.secondaryBrownColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                }),
                Divider(height: 24.h, color: Colors.grey.shade300),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      title: 'المجموع الكلي',
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        text(
                          title: controller.total.toStringAsFixed(0),
                          color: ColorsApp.primaryGreenColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 4.w),
                        text(
                          title: 'ج',
                          color: ColorsApp.primaryGreenColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingInfo extends StatelessWidget {
  const ShippingInfo({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.stateController,
    required this.addressController,
    required this.notesController,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController stateController;
  final TextEditingController addressController;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.local_shipping, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              text(
                title: 'معلومات الشحن',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomTextFieldInCheckout(
            controller: nameController,
            textInputAction: TextInputAction.next,
            label: 'الاسم',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الاسم';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFieldInCheckout(
            controller: phoneController,
            textInputAction: TextInputAction.next,
            label: 'رقم الهاتف',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال رقم الهاتف';
              }
              if (value.length < 11) {
                return 'رقم الهاتف غير صحيح';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFieldInCheckout(
            controller: stateController,
            textInputAction: TextInputAction.next,
            label: 'المحافظة',
            icon: Icons.location_city_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال المحافظة';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFieldInCheckout(
            controller: addressController,
            textInputAction: TextInputAction.done,
            label: 'العنوان التفصيلي',
            icon: Icons.location_on_outlined,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال العنوان';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFieldInCheckout(
            controller: notesController,
            label: 'ملاحظات (اختياري)',
            icon: Icons.notes_outlined,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldInCheckout extends StatelessWidget {
  const CustomTextFieldInCheckout({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.textInputAction,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(fontFamily: cairo),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp, fontFamily: cairo),
        prefixIcon: Icon(icon, color: ColorsApp.primaryGreenColor, size: 20.sp),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsApp.primaryGreenColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }
}

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});
  final controller = Get.find<CartController>();

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.payment, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              text(
                title: 'طريقة الدفع',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() {
            if (controller.paymentMethods.isEmpty) {
              return text(
                title: 'لا توجد طرق دفع متاحة',
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              );
            }

            return Column(
              children: controller.paymentMethods.map((method) {
                final isSelected = controller.selectedPaymentMethod.value?.id == method.id;
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: InkWell(
                    onTap: () => controller.selectPaymentMethod(method),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected ? ColorsApp.primaryGreenColor : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? ColorsApp.primaryGreenColor
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              color: isSelected ? ColorsApp.primaryGreenColor : Colors.transparent,
                            ),
                            child: isSelected
                                ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: text(
                              title: method.name,
                              color: isSelected
                                  ? ColorsApp.primaryGreenColor
                                  : Colors.grey.shade700,
                              fontSize: 14.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (method.name.contains('نقد'))
                            Icon(Icons.money, color: ColorsApp.primaryGreenColor, size: 24.sp),
                          if (method.name.contains('فيزا') || method.name.contains('بطاقة'))
                            Icon(
                              Icons.credit_card,
                              color: ColorsApp.primaryGreenColor,
                              size: 24.sp,
                            ),
                          if (method.name.contains('محفظة'))
                            Icon(
                              Icons.account_balance_wallet,
                              color: ColorsApp.primaryGreenColor,
                              size: 24.sp,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
