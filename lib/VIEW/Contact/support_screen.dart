import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class TechnicalSupportView extends StatelessWidget {
  const TechnicalSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(
      init: SupportController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: CustomAppBar(title: 'المهندس الزراعي', backButton: true),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value && controller.messages.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: ColorsApp.primaryGreenColor),
                            SizedBox(height: 16.h),
                            text(
                              title: 'جاري تحميل المحادثة...',
                              color: Colors.grey.shade600,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.all(16.w),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return ChatBubble(message: message);
                      },
                    );
                  }),
                ),
                Obx(() {
                  if (controller.commonQuestions.isNotEmpty) {
                    return QuickRepliesSection(controller: controller);
                  }
                  return SizedBox.shrink();
                }),
                ChatInputSection(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  bool get hasMedia {
    return message.imageUrl != null && message.imageUrl!.trim().isNotEmpty;
  }

  bool get isImage {
    if (!hasMedia) return false;

    final type = (message.messageType).toLowerCase().trim();
    final url = message.imageUrl!.toLowerCase();

    final validType = type == 'image' || type == 'file';
    final validExtension =
        url.endsWith('.png') ||
        url.endsWith('.jpg') ||
        url.endsWith('.jpeg') ||
        url.endsWith('.webp');

    return validType && validExtension;
  }

  bool get isLocalFile {
    if (!hasMedia) return false;
    final path = message.imageUrl!;
    return path.startsWith('/data/') || path.startsWith('file://');
  }

  String get fullImageUrl {
    if (isLocalFile) return message.imageUrl!;
    return EndPoints.imagesUrl + message.imageUrl!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.support_agent, color: Colors.white, size: 18.sp),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: isImage ? 250.w : 280.w),
              padding: EdgeInsets.all(isImage ? 8.w : 16.w),
              decoration: BoxDecoration(
                color: message.isUser
                    ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1)
                    : Colors.white,
                border: Border.all(
                  color: message.isUser
                      ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3)
                      : Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: !message.isUser ? Radius.circular(20.r) : Radius.circular(4.r),
                  bottomRight: !message.isUser ? Radius.circular(4.r) : Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: GestureDetector(
                        onTap: () => _showFullImage(context),
                        child: isLocalFile
                            ? Image.file(
                                File(message.imageUrl!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _imageError(),
                              )
                            : CachedNetworkImage(
                                imageUrl: fullImageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  height: 200.h,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: ColorsApp.primaryGreenColor,
                                  ),
                                ),
                                errorWidget: (_, __, ___) => _imageError(),
                              ),
                      ),
                    ),
                  ] else ...[
                    text(
                      title: message.text,
                      color: message.isUser ? ColorsApp.secondaryBrownColor : Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text(title: message.time, color: Colors.grey.shade500, fontSize: 11.sp),
                      if (message.isCommonQuestion) ...[
                        SizedBox(width: 6.w),
                        Icon(Icons.lightbulb, size: 12.sp, color: Colors.amber),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: ColorsApp.primaryGreenColor, size: 18.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget _imageError() {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Icon(Icons.broken_image, size: 40.sp, color: Colors.grey),
    );
  }

  void _showFullImage(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: isLocalFile
                    ? Image.file(File(message.imageUrl!))
                    : CachedNetworkImage(imageUrl: fullImageUrl, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 40.h,
              right: 20.w,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(Colors.black, 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickRepliesSection extends StatelessWidget {
  final SupportController controller;

  const QuickRepliesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, size: 16.sp, color: ColorsApp.primaryGreenColor),
                SizedBox(width: 6.w),
                text(
                  title: 'أسئلة شائعة',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 45.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              reverse: true,
              itemCount: controller.commonQuestions.length,
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              itemBuilder: (context, index) {
                final question = controller.commonQuestions[index];
                return QuickReplyButton(
                  title: question.question,
                  onTap: () => controller.handleCommonQuestion(question),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuickReplyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const QuickReplyButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
              ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.1),
            ],
          ),
          border: Border.all(color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3)),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: text(
            title: title,
            color: ColorsApp.secondaryBrownColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ChatInputSection extends StatelessWidget {
  final SupportController controller;

  const ChatInputSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.withOpacity(Colors.black, 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.pickAndSendFile(),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                  child: Icon(Icons.attach_file, color: ColorsApp.secondaryBrownColor, size: 22.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: TextField(
                    controller: controller.messageController,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87, fontFamily: cairo),
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.sp,
                        fontFamily: cairo,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onSubmitted: (value) => controller.sendMessage(value),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Obx(
                () => GestureDetector(
                  onTap: controller.isSending.value
                      ? null
                      : () => controller.sendMessage(controller.messageController.text),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: controller.isSending.value
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : Icon(Icons.send, color: Colors.white, size: 22.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
              SizedBox(width: 6.w),
              text(
                title: 'مستشار زراعي بشري - متاح من 8 صباحاً حتى 8 مساءً',
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
