import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class OrdersTab extends StatefulWidget {
  final bool withScaffold;

  const OrdersTab({super.key, this.withScaffold = false});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'all';
  String _sortType = 'date_desc';
  String _searchQuery = '';

  final List<Map<String, String>> _statuses = [
    {'value': 'all', 'label': 'الكل'},
    {'value': 'pending', 'label': 'قيد الانتظار'},
    {'value': 'processing', 'label': 'قيد التنفيذ'},
    {'value': 'shipped', 'label': 'تم الشحن'},
    {'value': 'delivered', 'label': 'تم التوصيل'},
    {'value': 'cancelled', 'label': 'ملغي'},
  ];

  final List<Map<String, String>> _sortOptions = [
    {'value': 'date_desc', 'label': 'الأحدث أولاً'},
    {'value': 'date_asc', 'label': 'الأقدم أولاً'},
    {'value': 'price_desc', 'label': 'الأعلى سعراً'},
    {'value': 'price_asc', 'label': 'الأقل سعراً'},
  ];

  List<OrderModel> _applyFilters(List<OrderModel> orders) {
    var list = [...orders];

    if (_selectedStatus != 'all') {
      list = list.where((o) => o.status == _selectedStatus).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list.where((o) => o.id.toString().contains(_searchQuery)).toList();
    }

    switch (_sortType) {
      case 'date_asc':
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'date_desc':
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'price_asc':
        list.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
        break;
      case 'price_desc':
        list.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
        break;
    }

    return list;
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsApp.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            text(
              title: 'ترتيب حسب',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: ColorsApp.secondaryBrownColor,
            ),
            SizedBox(height: 12.h),
            ..._sortOptions.map((option) {
              final isSelected = _sortType == option['value'];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  setState(() => _sortType = option['value']!);
                  Navigator.pop(context);
                },
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? ColorsApp.primaryGreenColor : Colors.grey,
                  size: 20.r,
                ),
                title: text(
                  title: option['label']!,
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? ColorsApp.primaryGreenColor : ColorsApp.secondaryBrownColor,
                ),
              );
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final currentSort = _sortOptions.firstWhere((s) => s['value'] == _sortType);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
                    ),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        selectionHandleColor: ColorsApp.primaryGreenColor,
                        selectionColor: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
                        cursorColor: ColorsApp.primaryGreenColor,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      cursorColor: ColorsApp.primaryGreenColor,
                      onTapOutside: (e) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 13.sp, fontFamily: cairo),
                      decoration: InputDecoration(
                        hintText: 'بحث برقم الطلب...',
                        hintStyle: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey,
                          fontFamily: cairo,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 18.r,
                          color: ColorsApp.primaryGreenColor,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                                child: Icon(Icons.close, size: 16.r, color: Colors.grey),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (v) => setState(() => _searchQuery = v.trim()),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => _showSortSheet(context),
                child: Container(
                  height: 42.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sort_rounded, size: 18.r, color: ColorsApp.primaryGreenColor),
                      SizedBox(width: 6.w),
                      text(
                        title: currentSort['label']!,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.primaryGreenColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _statuses.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, i) {
              final status = _statuses[i];
              final isSelected = _selectedStatus == status['value'];
              return GestureDetector(
                onTap: () => setState(() => _selectedStatus = status['value']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsApp.primaryGreenColor
                        : ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.07),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorsApp.primaryGreenColor
                          : ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
                    ),
                  ),
                  child: Center(
                    child: text(
                      title: status['label']!,
                      fontSize: 12.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : ColorsApp.primaryGreenColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    final content = Obx(() {
      if (controller.isLoading.value) {
        return const OrdersShimmer();
      }

      final filtered = _applyFilters(controller.orders);

      if (controller.orders.isEmpty) {
        return RefreshIndicator(
          color: ColorsApp.primaryGreenColor,
          onRefresh: () => controller.fetchOrders(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        size: 60.sp,
                        color: ColorsApp.primaryGreenColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    text(
                      title: 'لا توجد طلبات',
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    text(
                      title: 'ابدأ بالتسوق الآن',
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: ColorsApp.primaryGreenColor,
        onRefresh: () => controller.fetchOrders(),
        child: filtered.isEmpty
            ? ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded, size: 60.sp, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        text(
                          title: 'لا توجد نتائج',
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) => OrderCard(order: filtered[i]),
              ),
      );
    });

    final body = Column(
      children: [
        SizedBox(height: 12.h),
        _buildFilterBar(context),
        Expanded(child: content),
      ],
    );

    if (widget.withScaffold) {
      return Scaffold(
        backgroundColor: ColorsApp.backgroundColor,
        appBar: CustomAppBar(title: 'طلباتي'),
        body: body,
      );
    }

    return body;
  }
}
