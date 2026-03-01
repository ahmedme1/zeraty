import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class ProfileController extends GetxController {
  final logoutController = Get.find<LogoutController>();
  int selectedTabIndex = 2;

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);
  final Rx<File?> selectedImage = Rx<File?>(null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController engineerCodeController = TextEditingController();

  String? selectedGovernorate;
  String? selectedCenter;
  List<String> availableCenters = [];

  List<String> get governorates => egyptGovCenters.keys.toList();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchOrders();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    engineerCodeController.dispose();
    super.onClose();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.me,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = UserResponse.fromJson(response.data);
        if (userResponse.success) {
          user.value = userResponse.data;

          final name = response.data["data"]["name"];
          final image = response.data["data"]["image_url"];
          CacheHelper.saveData(key: userName, value: name ?? '');
          CacheHelper.saveData(key: userImage, value: image ?? '');
          printLog(response.data);
          _populateFields();
        }
      }
    } catch (e) {
      printLog('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    if (user.value != null) {
      nameController.text = user.value!.name;
      emailController.text = user.value!.email ?? '';
      phoneController.text = user.value!.phone;
      addressController.text = user.value!.address ?? '';
      engineerCodeController.text = user.value!.engineerCode ?? '';
      selectedGovernorate = user.value!.city;
      selectedCenter = user.value!.state;

      if (selectedGovernorate != null && egyptGovCenters.containsKey(selectedGovernorate)) {
        availableCenters = egyptGovCenters[selectedGovernorate!]!;
      }

      update();
    }
  }

  Future<void> fetchOrders({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.orders,
        query: {'page': page},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final ordersResponse = OrdersResponse.fromJson(response.data);
        if (ordersResponse.success) {
          orders.value = ordersResponse.data;
          pagination.value = ordersResponse.pagination;
        }
      }
    } catch (e) {
      printLog('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final formData = FormData.fromMap({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'engineer_code': engineerCodeController.text,
        'city': selectedGovernorate ?? '',
        'state': selectedCenter ?? '',
        if (selectedImage.value != null)
          'image': await MultipartFile.fromFile(
            selectedImage.value!.path,
            filename: 'profile_image.jpg',
          ),
      });

      final response = await DioHelper.updateForm(
        url: EndPoints.updateProfile,
        data: formData,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackbar.success('تم تحديث البيانات بنجاح');
        await fetchUserData();
        selectedImage.value = null;
      }
    } catch (e) {
      printLog('Error updating profile: $e');
      CustomSnackbar.error('فشل تحديث البيانات');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTabIndex = index;
    update();
  }

  Widget currentTabWidget() {
    switch (selectedTabIndex) {
      case 1:
        return OrdersTab(controller: this);
      case 2:
        return AccountTab(controller: this);
      default:
        return const SizedBox.shrink();
    }
  }

  void onGovernorateChanged(String? value) {
    selectedGovernorate = value;
    selectedCenter = null;

    if (value != null && egyptGovCenters.containsKey(value)) {
      availableCenters = egyptGovCenters[value]!;
    } else {
      availableCenters = [];
    }

    update();
  }

  void onCenterChanged(String? value) {
    selectedCenter = value;
    update();
  }

  String get name => user.value?.name ?? '';
  String get email => user.value?.email ?? '';
  String get phone => user.value?.phone ?? '';
  String? get fax => user.value?.engineerCode;

  final String welcomeMessage = 'مرحبا بك في تطبيقنا';
  final List<WelcomePoint> welcomePoints = [
    WelcomePoint(
      title: 'استمتع بتجربة تسوق فريدة',
      subtitle: 'اكتشف منتجاتنا الزراعية عالية الجودة',
    ),
    WelcomePoint(title: 'خدمة عملاء متميزة', subtitle: 'نحن هنا لمساعدتك في أي وقت'),
    WelcomePoint(title: 'توصيل سريع وآمن', subtitle: 'نضمن وصول طلباتك في الوقت المحدد'),
  ];

  void saveChanges() => updateProfile();

  void convertToMerchant() {
    CustomSnackbar.info('جاري العمل على هذه الميزة');
  }

  void logout() {
    if (getToken().isNotEmpty) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => ConfirmationDialog.show(
          title: 'هل أنت متأكد ؟'.tr,
          subtitle: 'هل تريد تسجيل الخروج ؟'.tr,
          onConfirm: () => logoutController.logout(),
          onCancel: () => Get.back(),
        ),
      );
    } else {
      Get.offAll(() => LoginScreen(), transition: Transition.fade);
    }
  }

  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: text(
          title: 'حذف الحساب',
          color: Colors.red,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        content: text(
          title: 'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
          color: Colors.grey.shade700,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
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
              CustomSnackbar.error('تم حذف الحساب');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: text(
              title: 'حذف',
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

class WelcomePoint {
  final String title;
  final String? subtitle;

  WelcomePoint({required this.title, this.subtitle});
}
