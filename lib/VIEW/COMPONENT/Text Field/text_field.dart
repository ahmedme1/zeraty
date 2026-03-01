// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class CustomTitleTextField extends StatelessWidget {
  const CustomTitleTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hint,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.filledColor = Colors.white,
    this.textColor = ColorsApp.titleColor,
    this.fontWeight,
    this.borderRadius = 25,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.borderColor = Colors.grey,
    this.hintColor = Colors.grey,
    this.onSubmitted,
    this.height,
    this.contentPadding,
    this.isDense = true,
    this.borderWidth = 1,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final Color textColor;
  final FontWeight? fontWeight;
  final bool readOnly;
  final maxLines;
  final double borderRadius;
  final Color filledColor;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Color borderColor;
  final Color hintColor;
  final void Function(String)? onSubmitted;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDense;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    String fontFamily = cairo;

    final field = TextFormField(
      controller: controller,
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      cursorColor: ColorsApp.titleColor,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.sp,
        color: textColor,
        fontWeight: fontWeight,
      ),
      decoration: InputDecoration(
        isDense: isDense,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        hintText: hint,
        hintStyle: TextStyle(fontFamily: fontFamily, fontSize: 12.sp, color: hintColor),
        fillColor: filledColor,
        filled: true,
      ),
    );

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: ColorsApp.secondaryBrownColor,
        selectionColor: ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.3),
        selectionHandleColor: ColorsApp.secondaryBrownColor,
      ),
      child: height == null ? field : SizedBox(height: height!.h, child: field),
    );
  }
}
