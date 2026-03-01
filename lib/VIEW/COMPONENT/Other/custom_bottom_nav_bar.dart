// import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
// import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
// import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   final int selectedIndex;
//   final List<Map<String, String>> items;
//   final Function(int) onTap;
//   final Map<int, int>? badges;

//   const CustomBottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.items,
//     required this.onTap,
//     this.badges,
//   });

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> with TickerProviderStateMixin {
//   late AnimationController _pillController;
//   late Animation<double> _pillAnim;
//   int _prevIndex = 0;
//   late List<AnimationController> _itemControllers;
//   late List<Animation<double>> _scaleAnims;
//   late List<Animation<double>> _floatAnims;
//   late List<Animation<double>> _labelFadeAnims;

//   @override
//   void initState() {
//     super.initState();
//     _prevIndex = widget.selectedIndex;
//     _pillController = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
//     _pillAnim = Tween<double>(
//       begin: widget.selectedIndex.toDouble(),
//       end: widget.selectedIndex.toDouble(),
//     ).animate(CurvedAnimation(parent: _pillController, curve: Curves.easeInOutCubic));
//     _itemControllers = List.generate(
//       widget.items.length,
//       (i) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 550),
//         value: i == widget.selectedIndex ? 1.0 : 0.0,
//       ),
//     );

//     _scaleAnims = _itemControllers
//         .map(
//           (c) => Tween<double>(
//             begin: 1.0,
//             end: 1.18,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.elasticOut)),
//         )
//         .toList();

//     _floatAnims = _itemControllers
//         .map(
//           (c) => Tween<double>(
//             begin: 0.0,
//             end: -2.0,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic)),
//         )
//         .toList();

//     _labelFadeAnims = _itemControllers
//         .map(
//           (c) => Tween<double>(
//             begin: 0.4,
//             end: 1.0,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeIn)),
//         )
//         .toList();
//   }

//   @override
//   void didUpdateWidget(CustomBottomNavBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedIndex != widget.selectedIndex) {
//       _pillAnim = Tween<double>(
//         begin: _prevIndex.toDouble(),
//         end: widget.selectedIndex.toDouble(),
//       ).animate(CurvedAnimation(parent: _pillController, curve: Curves.easeInOutCubic));
//       _pillController.forward(from: 0);
//       _itemControllers[_prevIndex].reverse();
//       _itemControllers[widget.selectedIndex].forward();

//       _prevIndex = widget.selectedIndex;
//     }
//   }

//   @override
//   void dispose() {
//     _pillController.dispose();
//     for (var c in _itemControllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final itemWidth = constraints.maxWidth / widget.items.length;
//           final pillSize = 52.0;

//           return SizedBox(
//             height: 72.h,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(26.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorsApp.applyOpacity(Colors.black, 0.09),
//                           blurRadius: 28,
//                           spreadRadius: 0,
//                           offset: const Offset(0, 10),
//                         ),
//                         BoxShadow(
//                           color: ColorsApp.applyOpacity(ColorsApp.primaryGreenColor, 0.06),
//                           blurRadius: 40,
//                           spreadRadius: -4,
//                           offset: const Offset(0, 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 AnimatedBuilder(
//                   animation: _pillAnim,
//                   builder: (context, _) {
//                     final reversedValue = (widget.items.length - 1) - _pillAnim.value;
//                     final leftPos = reversedValue * itemWidth + (itemWidth - pillSize) / 2;
//                     return Positioned(
//                       left: leftPos,
//                       top: (72.h - pillSize) / 2,
//                       child: Container(
//                         width: pillSize,
//                         height: pillSize,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [ColorsApp.primaryGreenColor, Color(0xFF2E7D32)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(18.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorsApp.applyOpacity(ColorsApp.primaryGreenColor, 0.38),
//                               blurRadius: 18,
//                               spreadRadius: -2,
//                               offset: const Offset(0, 8),
//                             ),
//                             BoxShadow(
//                               color: ColorsApp.applyOpacity(ColorsApp.primaryGreenColor, 0.15),
//                               blurRadius: 30,
//                               spreadRadius: -4,
//                               offset: const Offset(0, 14),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 Row(
//                   children: List.generate(widget.items.length, (index) {
//                     return NavItem(
//                       width: itemWidth,
//                       item: widget.items[index],
//                       isSelected: widget.selectedIndex == index,
//                       scaleAnim: _scaleAnims[index],
//                       floatAnim: _floatAnims[index],
//                       labelFadeAnim: _labelFadeAnims[index],
//                       onTap: () => widget.onTap(index),
//                       badgeCount: widget.badges?[index],
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class NavItem extends StatelessWidget {
//   final double width;
//   final Map<String, String> item;
//   final bool isSelected;
//   final int? badgeCount;
//   final Animation<double> scaleAnim;
//   final Animation<double> floatAnim;
//   final Animation<double> labelFadeAnim;
//   final VoidCallback onTap;

//   const NavItem({
//     super.key,
//     required this.width,
//     required this.item,
//     required this.isSelected,
//     this.badgeCount,
//     required this.scaleAnim,
//     required this.floatAnim,
//     required this.labelFadeAnim,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: SizedBox(
//         width: width,
//         child: AnimatedBuilder(
//           animation: Listenable.merge([scaleAnim, floatAnim, labelFadeAnim]),
//           builder: (context, _) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     SvgPicture.asset(
//                       item['icon']!,
//                       height: 22.h,
//                       width: 22.w,
//                       colorFilter: ColorFilter.mode(
//                         isSelected ? Colors.white : ColorsApp.primaryGreenColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     if (badgeCount != null && badgeCount! > 0)
//                       Positioned(
//                         top: -6.h,
//                         left: -6.w,
//                         child: Container(
//                           constraints: BoxConstraints(minWidth: 18.w),
//                           height: 18.h,
//                           padding: EdgeInsets.symmetric(horizontal: 4.w),

//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [ColorsApp.secondaryBrownColor, ColorsApp.primaryGreenColor],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(30.r),
//                             border: Border.all(
//                               color: isSelected ? Colors.white : ColorsApp.primaryGreenColor,
//                               width: 1.5,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: ColorsApp.applyOpacity(ColorsApp.secondaryBrownColor, 0.5),
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           alignment: Alignment.center,
//                           child: text(
//                             title: badgeCount! > 99 ? '99+' : badgeCount.toString(),
//                             color: Colors.white,
//                             fontSize: 9.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),

//                 if (!isSelected) ...[
//                   SizedBox(height: 5.h),
//                   Opacity(
//                     opacity: labelFadeAnim.value,
//                     child: text(
//                       title: item['label']!,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       fontSize: 11.sp,
//                       fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
//                       color: ColorsApp.primaryGreenColor,
//                     ),
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
