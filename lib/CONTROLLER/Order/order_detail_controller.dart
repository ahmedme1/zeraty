import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderDetailsController extends GetxController {
  final int orderId;

  final Rx<OrderDetailsModel?> orderDetails = Rx<OrderDetailsModel?>(null);
  final RxBool isLoading = false.obs;

  OrderDetailsController({required this.orderId});

  @override
  void onInit() {
    super.onInit();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: '${EndPoints.orders}/$orderId',
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);

        if (orderDetailsResponse.success) {
          orderDetails.value = orderDetailsResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching order details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
