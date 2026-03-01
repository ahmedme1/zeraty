import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

enum PaymentMethod { online, fromAdmin, withdrawal }

enum TransactionType { deposit, withdraw }

enum WithdrawalReason { lecturePurchase, codePurchase }

enum QuestionDataType { fillInTheBlank, multipleChoice, trueFalse }

enum LecturePrivacy { public, private }

String handlePaymentMethod(int paymentMethod) {
  switch (paymentMethod) {
    case 0:
      return 'اونلاين'.tr;
    case 1:
      return 'من المدير'.tr;
    case 2:
      return 'سحب'.tr;
    default:
      return ''.tr;
  }
}

String handleTransactionType(int transactionType) {
  switch (transactionType) {
    case 0:
      return 'إيداع'.tr;
    case 1:
      return 'سحب'.tr;

    default:
      return ''.tr;
  }
}

String handleWithdrawalReason(int withdrawalReason) {
  switch (withdrawalReason) {
    case 0:
      return 'شراء محاضرات'.tr;
    case 1:
      return 'شراء أكواد'.tr;

    default:
      return ''.tr;
  }
}

int garbageId = 146814684;
