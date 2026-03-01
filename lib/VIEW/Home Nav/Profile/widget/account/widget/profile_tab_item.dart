import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProfileTabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const ProfileTabItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: ColorsApp.withOpacity(Colors.black, 0.12),
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isActive
                    ? const Color(0xFF2E7D32)
                    : ColorsApp.withOpacity(Colors.white, 0.8),
              ),
              SizedBox(width: 7.w),
              text(
                title: label,
                color: isActive
                    ? const Color(0xFF2E7D32)
                    : ColorsApp.withOpacity(Colors.white, 0.8),
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
