import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutUsController());

    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      appBar: CustomAppBar(title: 'من نحن', backButton: true),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            FAQCard(
              item: controller.faqItems[0],
              index: 0,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  text(
                    title:
                        'هو التطبيق الرائد في مجال توفير المنتجات الزراعية عالية الجودة للمزارعين والمهتمين بالقطاع الزراعي.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'نحن نوفر مجموعة واسعة من الأسمدة، البذور، المبيدات، والأدوات الزراعية من أفضل الشركات المصنعة العالمية والمحلية.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'رؤيتنا هي دعم المزارع المصري والعربي بكل ما يحتاجه لتحقيق أفضل إنتاجية وجودة لمحاصيله.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'مهمتنا:',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorsApp.secondaryBrownColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'توفير منتجات زراعية أصلية وموثوقة',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'تقديم استشارات زراعية مجانية',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'خدمة توصيل سريعة وآمنة',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'أسعار عادلة ومنافسة',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      gradient: LinearGradient(
                        colors: [
                          ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.05),
                          ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        text(
                          title: 'شركة الخشبي للاسمده والمبيدات الزراعيه ',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorsApp.secondaryBrownColor,
                          textAlign: TextAlign.center,
                        ),
                        text(
                          title: 'انجال الحاج عبدالعزيز الخشبي ',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorsApp.secondaryBrownColor,
                          textAlign: TextAlign.center,
                        ),
                        text(
                          title: 'اداره البشمهندس/محمود الخشبي',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorsApp.secondaryBrownColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AddressInfo(),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            FAQCard(
              item: controller.faqItems[1],
              index: 1,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  text(
                    title:
                        'نحن نهتم برضاك التام عن منتجاتنا وخدماتنا. إذا واجهت أي مشكلة، نوفر لك سياسة استبدال واسترجاع واضحة وعادلة.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5.h,
                      children: [
                        text(
                          title: 'شروط الاستبدال:',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.secondaryBrownColor,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5.h),
                        text(
                          title: 'يمكن استبدال المنتج خلال 14 يوم من تاريخ الاستلام',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                        text(
                          title: 'يجب أن يكون المنتج في حالته الأصلية وبعبوته',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                        text(
                          title: 'يُشترط إحضار فاتورة الشراء الأصلية',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                        text(
                          title: 'المنتجات التالفة أو المعيبة تُستبدل فوراً',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5.h,
                      children: [
                        text(
                          title: 'سياسة الاسترجاع:',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.primaryGreenColor,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5.h),
                        text(
                          title: 'استرجاع كامل المبلغ في حالة المنتج المعيب',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                        text(
                          title: 'يتم معالجة الاسترجاع خلال 3-5 أيام عمل',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                        text(
                          title: 'يُعاد المبلغ بنفس طريقة الدفع الأصلية',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.textDarkColor,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            FAQCard(
              item: controller.faqItems[2],
              index: 2,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  CustomTerms(
                    title: '1. استخدام التطبيق',
                    desc:
                        'يجب استخدام التطبيق للأغراض القانونية فقط. يُمنع استخدام التطبيق لأي نشاط غير قانوني أو احتيالي.',
                  ),
                  CustomTerms(
                    title: '2. الحسابات',
                    desc:
                        'أنت مسؤول عن الحفاظ على سرية معلومات حسابك. يجب إبلاغنا فوراً بأي استخدام غير مصرح به.',
                  ),
                  CustomTerms(
                    title: '3. الأسعار والدفع',
                    desc:
                        'جميع الأسعار معروضة بالجنيه المصري. نحتفظ بالحق في تعديل الأسعار في أي وقت.',
                  ),
                  CustomTerms(
                    title: '4. الملكية الفكرية',
                    desc:
                        'جميع المحتويات والعلامات التجارية ملك لشركة زراعي ومحمية بموجب قوانين الملكية الفكرية.',
                  ),
                  CustomTerms(
                    title: '5. المسؤولية',
                    desc:
                        'نحن نبذل قصارى جهدنا لضمان دقة المعلومات، لكننا غير مسؤولين عن أي أضرار ناتجة عن استخدام المنتجات.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            FAQCard(
              item: controller.faqItems[3],
              index: 3,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [PhoneInfo(), AddressInfo()],
              ),
            ),
            SizedBox(height: 10.h),
            FAQCard(
              item: controller.faqItems[4],
              index: 4,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  text(
                    title: 'نحرص في تطبيق زراعي على توصيل الطلبات في أسرع وقت وبأفضل جودة ممكنة.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يتم تجهيز الطلبات بعد تأكيدها خلال مدة تتراوح من 24 إلى 48 ساعة حسب نوع المنتج وتوفره.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'تختلف مدة الشحن حسب المحافظة ومكان التسليم، ويتم تحديد الموعد المتوقع أثناء إتمام الطلب.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'يتحمل العميل تكلفة الشحن والتي يتم توضيحها قبل تأكيد الطلب.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'في حالة عدم تواجد العميل في عنوان التسليم، يتم التواصل لإعادة جدولة التوصيل.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title: 'يتحمل العميل مسؤولية التأكد من صحة بيانات العنوان ورقم الهاتف.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'في حال وجود أي تلف أو مشكلة في الطلب، يرجى التواصل معنا فور الاستلام لاتخاذ اللازم.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            FAQCard(
              item: controller.faqItems[5],
              index: 5,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  text(
                    title:
                        'نحرص في تطبيق زراعي على حماية خصوصية المستخدمين والحفاظ على سرية بياناتهم، ونعمل دائمًا على استخدام المعلومات بطريقة آمنة ومسؤولة.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يقوم التطبيق بجمع بعض البيانات الأساسية مثل الاسم ورقم الهاتف والعنوان، وذلك بهدف إتمام الطلبات وتحسين جودة الخدمة.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يتم استخدام البيانات التي يتم جمعها للتواصل مع المستخدم، وتنفيذ الطلبات، وتقديم العروض والخدمات المناسبة.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يلتزم التطبيق بعدم مشاركة بيانات المستخدم مع أي طرف ثالث إلا في حدود تنفيذ الخدمة أو وفقًا لما يفرضه القانون.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يتم تأمين البيانات باستخدام وسائل حماية مناسبة لمنع الوصول غير المصرح به أو التعديل أو الفقدان.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'يحق للمستخدم تحديث أو تعديل بياناته الشخصية من خلال الحساب الخاص به داخل التطبيق.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                  text(
                    title:
                        'باستخدامك للتطبيق، فإنك توافق على سياسة الخصوصية هذه وجميع التحديثات التي قد تطرأ عليها.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsApp.textDarkColor,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class CustomTerms extends StatelessWidget {
  const CustomTerms({super.key, required this.title, required this.desc});
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: ColorsApp.secondaryBrownColor, width: 3.74.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 7.h,
        children: [
          text(
            title: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: ColorsApp.secondaryBrownColor,
            textAlign: TextAlign.start,
          ),
          text(
            title: desc,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ColorsApp.textDarkColor,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final FAQItem item;
  final int index;
  final Widget widget;
  const FAQCard({super.key, required this.item, required this.index, required this.widget});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutUsController>();

    return Obx(() {
      final isExpanded = controller.expandedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.toggleExpanded(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),

            boxShadow: [
              BoxShadow(
                color: ColorsApp.withOpacity(Colors.black, 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 10.w,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            color: Colors.grey.shade100,
                            gradient: isExpanded
                                ? LinearGradient(
                                    colors: [
                                      ColorsApp.secondaryBrownColor,
                                      ColorsApp.primaryGreenColor,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                          ),

                          child: SvgPicture.asset(
                            item.icon,
                            colorFilter: ColorFilter.mode(
                              isExpanded ? Colors.white : ColorsApp.secondaryBrownColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        text(
                          title: item.question,
                          color: isExpanded ? ColorsApp.secondaryBrownColor : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                    size: 24.sp,
                  ),
                ],
              ),
              if (isExpanded) ...[
                SizedBox(height: 12.h),
                Divider(color: Colors.grey.shade300, height: 1),
                SizedBox(height: 12.h),
                widget,
              ],
            ],
          ),
        ),
      );
    });
  }
}
