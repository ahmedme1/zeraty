import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class CheckLogin extends StatefulWidget {
  final Widget child;

  const CheckLogin({super.key, required this.child});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnim = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getToken().isNotEmpty) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Opacity(
          opacity: _fadeAnim.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnim.value),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: _scaleAnim.value,
                      child: Container(
                        width: 110.w,
                        height: 110.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              ColorsApp.primaryGreenColor,
                              ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
                              blurRadius: 30,
                              spreadRadius: -4,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Icon(Icons.eco_rounded, size: 52.sp, color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 32.h),
                    text(
                      title: 'أهلاً بك في زراعتي 🌿',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: ColorsApp.secondaryBrownColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    text(
                      title: 'سجّل دخولك واستمتع بتجربة تسوق زراعية متكاملة من بيتك',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 36.h),
                    GestureDetector(
                      onTap: () => Get.offAll(() => LoginScreen(), transition: Transition.fadeIn),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ColorsApp.primaryGreenColor, Color(0xFF2E7D32)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.4),
                              blurRadius: 20,
                              spreadRadius: -4,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8.w,
                          children: [
                            Icon(Icons.login_rounded, color: Colors.white, size: 20.sp),
                            text(
                              title: 'تسجيل الدخول',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () =>
                          Get.offAll(() => RegisterScreen(), transition: Transition.fadeIn),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8.w,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: ColorsApp.primaryGreenColor,
                              size: 20.sp,
                            ),
                            text(
                              title: 'إنشاء حساب جديد',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorsApp.primaryGreenColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
