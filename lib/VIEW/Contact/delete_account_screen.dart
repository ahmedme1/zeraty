import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _confirmed = false;

  late AnimationController _shakeController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _shakeController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _handleDelete() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_confirmed) {
      _shakeController.forward(from: 0);
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() => _isLoading = false);
      removeUserData();
      Get.offAll(() => LoginScreen(), transition: Transition.fade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 32.h),
                  _buildWarningCard(),
                  SizedBox(height: 28.h),
                  _buildNoticeCard(),
                  SizedBox(height: 28.h),
                  _buildInputs(),
                  SizedBox(height: 24.h),
                  _buildConfirmCheckbox(),
                  SizedBox(height: 32.h),
                  _buildDeleteButton(),
                  SizedBox(height: 16.h),
                  _buildCancelButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70, size: 16.sp),
          ),
        ),
        SizedBox(height: 28.h),

        text(
          title: 'حذف الحساب'.tr,
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        SizedBox(height: 6.h),
        text(
          title: 'هذا الإجراء لا يمكن التراجع عنه'.tr,
          fontSize: 14.sp,
          color: Colors.white38,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A0A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsApp.withOpacity(Color(0xFFFF3B3B), 0.2)),
      ),
      child: Column(
        children: [
          _warningItem(Icons.photo_library_outlined, 'سيتم حذف جميع بياناتك وحجوزاتك'.tr),
          SizedBox(height: 12.h),
          _warningItem(Icons.history_rounded, 'لن تتمكن من استرجاع سجل رحلاتك'.tr),
          SizedBox(height: 12.h),
          _warningItem(Icons.account_circle_outlined, 'سيتم إلغاء اشتراكك نهائياً'.tr),
        ],
      ),
    );
  }

  Widget _warningItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF3B3B), size: 18.sp),
        SizedBox(width: 10.w),
        Expanded(
          child: text(title: title, fontSize: 13.sp, color: Colors.white60, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildNoticeCard() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1A0F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorsApp.withOpacity(Color(0xFF2ECC71), 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: const Color(0xFF2ECC71), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: text(
              title: 'سيتم مراجعة طلب الحذف في مدة أقصاها 24 ساعة من تاريخ التقديم.'.tr,
              fontSize: 13.sp,
              color: ColorsApp.withOpacity(Color(0xFF2ECC71), 0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          title: 'تأكيد هويتك'.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _emailController,
          hint: 'البريد الإلكتروني'.tr,
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            if (val == null || val.isEmpty) return 'أدخل البريد الإلكتروني'.tr;
            if (!val.contains('@')) return 'بريد إلكتروني غير صحيح'.tr;
            return null;
          },
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _passwordController,
          hint: 'كلمة المرور'.tr,
          icon: Icons.lock_outline_rounded,
          obscure: _obscurePassword,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscurePassword = !_obscurePassword),
            child: Icon(
              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.white38,
              size: 20.sp,
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) return 'أدخل كلمة المرور'.tr;
            if (val.length < 6) return 'كلمة المرور قصيرة'.tr;
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontFamily: cairo),
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white30, fontSize: 14.sp, fontFamily: cairo),
        prefixIcon: Icon(icon, color: Colors.white30, size: 20.sp),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        errorStyle: TextStyle(fontSize: 11.sp, color: const Color(0xFFFF6B6B), fontFamily: cairo),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFFFF3B3B), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }

  Widget _buildConfirmCheckbox() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final shake = (_shakeController.value * 10).round() % 2 == 0 ? -4.0 : 4.0;
        final offset = _shakeController.isAnimating ? shake : 0.0;
        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: GestureDetector(
        onTap: () => setState(() => _confirmed = !_confirmed),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: _confirmed ? const Color(0xFF2A0A0A) : const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: _confirmed
                  ? ColorsApp.withOpacity(Color(0xFFFF3B3B), 0.5)
                  : const Color(0xFF2A2A2A),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: _confirmed ? const Color(0xFFFF3B3B) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: _confirmed ? const Color(0xFFFF3B3B) : Colors.white30,
                    width: 1.5,
                  ),
                ),
                child: _confirmed
                    ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: text(
                  title: 'أفهم أن هذا الإجراء نهائي ولا يمكن التراجع عنه'.tr,
                  fontSize: 13.sp,
                  color: _confirmed ? Colors.white70 : Colors.white38,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleDelete,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF3B3B),
          disabledBackgroundColor: ColorsApp.withOpacity(Color(0xFFFF3B3B), 0.6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          elevation: 0,
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  ),
                  SizedBox(width: 12.w),
                  text(
                    title: 'جارٍ معالجة الطلب...'.tr,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              )
            : text(
                title: 'حذف حسابي نهائياً'.tr,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: TextButton(
        onPressed: () => Get.back(),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: text(
          title: 'إلغاء'.tr,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white38,
        ),
      ),
    );
  }
}
