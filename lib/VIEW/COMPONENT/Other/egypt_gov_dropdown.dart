import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.svgAsset,
    required this.value,
    required this.items,
    required this.onChanged,
    this.disabled = false,
  });

  final String label;
  final String hint;
  final String svgAsset;
  final String? value;
  final RxList<String> items;
  final void Function(String?)? onChanged;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: disabled ? Colors.grey.shade300 : Colors.grey.shade400),
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
            title: label,
            fontSize: 16.sp,
            color: ColorsApp.secondaryBrownColor,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField2<String>(
            value: value,
            isExpanded: true,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontFamily: cairo, fontSize: 12.sp),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  svgAsset,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                  colorFilter: disabled
                      ? ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn)
                      : null,
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 48.w, minHeight: 48.w),
              enabled: !disabled,
              border: border,
              enabledBorder: border,
              disabledBorder: border,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: text(
                      title: e,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14.sp,
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              maxHeight: 280.h,
            ),
            menuItemStyleData: MenuItemStyleData(height: 46.h),
          ),
        ],
      ),
    );
  }
}

class EgyptGovDropdown extends StatelessWidget {
  const EgyptGovDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.svgAsset,
    required this.value,
    required this.items,
    required this.onChanged,
    this.disabled = false,
  });

  final String label;
  final String hint;
  final String svgAsset;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.r),
      borderSide: BorderSide(color: disabled ? Colors.grey.shade300 : Colors.grey.shade300),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(title: label, fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w700),
        SizedBox(height: 8.h),
        DropdownButtonFormField2<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: cairo, fontSize: 16.sp, color: Colors.grey.shade400),
            enabled: !disabled,
            border: border,
            enabledBorder: border,
            disabledBorder: border,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: text(
                    title: e,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14.sp,
                    textAlign: TextAlign.start,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorsApp.primaryGreenColor,
              size: 24.sp,
            ),
          ),

          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: Colors.white,
            ),
            maxHeight: 280.h,
          ),
          menuItemStyleData: MenuItemStyleData(height: 46.h),
        ),
      ],
    );
  }
}
