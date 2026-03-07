import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

enum SnackbarType { success, error, warning, info }

class CustomSnackbar {
  static OverlayEntry? _currentEntry;

  static void show({
    required String message,
    required SnackbarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    _currentEntry?.remove();
    _currentEntry = null;

    HapticFeedback.vibrate();
    final config = _getConfig(type);

    final overlay = Navigator.of(Get.context!).overlay;
    if (overlay == null) return;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => SnackbarWidget(
        message: message,
        config: config,
        duration: duration,
        onDismiss: () {
          entry.remove();
          if (_currentEntry == entry) _currentEntry = null;
        },
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  static SnackConfig _getConfig(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return SnackConfig(
          icon: Icons.check_rounded,
          color: ColorsApp.successColor,
          glowColor: ColorsApp.successColor,
          label: 'تم',
        );
      case SnackbarType.error:
        return SnackConfig(
          icon: Icons.close_rounded,
          color: ColorsApp.errorColor,
          glowColor: ColorsApp.errorColor,
          label: 'خطأ',
        );
      case SnackbarType.warning:
        return SnackConfig(
          icon: Icons.warning_amber_rounded,
          color: ColorsApp.warningColor,
          glowColor: ColorsApp.warningColor,
          label: 'تنبيه',
        );
      case SnackbarType.info:
        return SnackConfig(
          icon: Icons.info_outline_rounded,
          color: ColorsApp.infoColor,
          glowColor: ColorsApp.infoColor,
          label: 'معلومة',
        );
    }
  }

  static void success(String message, {Duration? duration}) => show(
    message: message,
    type: SnackbarType.success,
    duration: duration ?? Duration(seconds: 3),
  );
  static void error(String message, {Duration? duration}) =>
      show(message: message, type: SnackbarType.error, duration: duration ?? Duration(seconds: 4));
  static void warning(String message, {Duration? duration}) => show(
    message: message,
    type: SnackbarType.warning,
    duration: duration ?? Duration(seconds: 4),
  );
  static void info(String message, {Duration? duration}) =>
      show(message: message, type: SnackbarType.info, duration: duration ?? Duration(seconds: 3));
}

class SnackConfig {
  final IconData icon;
  final Color color;
  final Color glowColor;
  final String label;
  const SnackConfig({
    required this.icon,
    required this.color,
    required this.glowColor,
    required this.label,
  });
}

class SnackbarWidget extends StatefulWidget {
  final String message;
  final SnackConfig config;
  final Duration duration;
  final VoidCallback onDismiss;

  const SnackbarWidget({
    super.key,
    required this.message,
    required this.config,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<SnackbarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(0.0, 0.7, curve: Curves.easeOutExpo),
      ),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _ctrl.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _dismiss();
    });
  }

  void _dismiss() async {
    await _ctrl.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32.h,
      left: 16.w,
      right: 16.w,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: widget.config.color,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: ColorsApp.withOpacity(widget.config.color, 0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.withOpacity(widget.config.glowColor, 0.25),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                  BoxShadow(
                    color: ColorsApp.withOpacity(Colors.black, 0.4),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ScaleTransition(
                    scale: _iconScale,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: ColorsApp.withOpacity(Colors.white, 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorsApp.withOpacity(Colors.white, 0.3)),
                      ),
                      child: Icon(widget.config.icon, color: Colors.white, size: 18.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 1,
                    height: 36.h,
                    color: ColorsApp.withOpacity(widget.config.color, 0.2),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: text(
                      title: widget.message,
                      color: ColorsApp.withOpacity(Colors.white, 0.9),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      _dismiss();
                    },
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorsApp.withOpacity(Colors.white, 0.3)),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close_rounded, color: Colors.white, size: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
