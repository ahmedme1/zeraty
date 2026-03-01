import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class AboutUsController extends GetxController {
  final RxInt expandedIndex = (-1).obs;

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'عن زراعي',
      answer:
          'نحن شركة رائدة في مجال التجارة الإلكترونية، نقدم أفضل المنتجات والخدمات لعملائنا. نسعى دائماً لتوفير تجربة تسوق مميزة وآمنة.',
      icon: ImagesApp.info2,
    ),
    FAQItem(
      question: 'سياسة الاستبدال والاسترجاع',
      answer:
          'يمكنك إنشاء حساب جديد من خلال الضغط على زر "تسجيل" في الصفحة الرئيسية، ثم ملء البيانات المطلوبة وتفعيل حسابك عبر البريد الإلكتروني.',
      icon: ImagesApp.box,
    ),
    FAQItem(
      question: 'الشروط والأحكام',
      answer:
          'نوفر عدة طرق للدفع تشمل: الدفع عند الاستلام، البطاقات الائتمانية، المحافظ الإلكترونية، والتحويل البنكي.',
      icon: ImagesApp.sheet,
    ),
    FAQItem(
      question: 'اتصل بنا',
      answer:
          'عادة ما تستغرق عملية التوصيل من 2 إلى 5 أيام عمل حسب موقعك الجغرافي. نقدم أيضاً خدمة التوصيل السريع في بعض المناطق.',
      icon: ImagesApp.phone,
    ),
    FAQItem(
      question: 'سياسة الشحن والتوصيل',
      answer:
          'نعم، يمكنك إرجاع المنتج خلال 14 يوماً من تاريخ الاستلام بشرط أن يكون في حالته الأصلية مع العبوة والفاتورة.',
      icon: ImagesApp.box,
    ),
    FAQItem(
      question: 'سياسة الخصوصية',
      answer:
          'يمكنك تتبع طلبك من خلال الدخول إلى حسابك والضغط على "طلباتي"، ستجد رقم التتبع وحالة الطلب الحالية.',
      icon: ImagesApp.privacy,
    ),
  ];
}

class FAQItem {
  final String question;
  final String answer;
  final String icon;

  FAQItem({required this.question, required this.answer, required this.icon});
}
