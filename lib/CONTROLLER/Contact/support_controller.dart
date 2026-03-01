import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class SupportController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<CommonQuestionModel> commonQuestions = <CommonQuestionModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final Rx<ChatModel?> currentChat = Rx<ChatModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCommonQuestions();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.chat,
        sendAuthToken: true,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final chatResponse = ChatResponse.fromJson(response.data);

        if (chatResponse.success) {
          currentChat.value = chatResponse.chat;
          _loadPreviousMessages(chatResponse.messages);
        } else {
          addWelcomeMessage();
        }
      } else {
        addWelcomeMessage();
      }
    } catch (e) {
      printLog('Error fetching chat history: $e');
      addWelcomeMessage();
    } finally {
      isLoading.value = false;
    }
  }

  void _loadPreviousMessages(List<ChatMessageModel> serverMessages) {
    messages.clear();

    if (serverMessages.isEmpty) {
      addWelcomeMessage();
      return;
    }

    for (var serverMessage in serverMessages) {
      final type = (serverMessage.messageType).toLowerCase();

      messages.add(
        ChatMessage(
          text: serverMessage.content,
          isUser: serverMessage.senderType == 'user',
          time: _formatServerTime(serverMessage.createdAt),
          messageType: type,
          imageUrl: (type == 'image' || type == 'file') ? serverMessage.content : null,
          isLocalImage: false,
        ),
      );
    }

    _scrollToBottom();
  }

  void addWelcomeMessage() {
    if (messages.isEmpty) {
      messages.add(
        ChatMessage(
          text: 'مرحباً! أنا المهندس أحمد، مستشارك الزراعي. كيف يمكنني مساعدتك اليوم؟',
          isUser: false,
          time: _getCurrentTime(),
        ),
      );
    }
  }

  Future<void> fetchCommonQuestions() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.commonQuestions,
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final commonQuestionsResponse = CommonQuestionsResponse.fromJson(response.data);

        if (commonQuestionsResponse.success) {
          commonQuestions.value = commonQuestionsResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching common questions: $e');
    }
  }

  void handleCommonQuestion(CommonQuestionModel question) {
    messages.add(
      ChatMessage(
        text: question.question,
        isUser: true,
        time: _getCurrentTime(),
        isCommonQuestion: true,
      ),
    );

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 500), () {
      messages.add(ChatMessage(text: question.answer, isUser: false, time: _getCurrentTime()));
      _scrollToBottom();
    });
  }

  Future<void> sendMessage(String message, {String? filePath}) async {
    if (message.trim().isEmpty && filePath == null) return;

    final String messageText = message.trim().isNotEmpty ? message : 'تم إرسال ملف';

    messages.add(
      ChatMessage(
        text: messageText,
        isUser: true,
        time: _getCurrentTime(),
        messageType: filePath != null ? 'image' : 'text',
        imageUrl: filePath,
        isLocalImage: filePath != null,
      ),
    );

    messageController.clear();
    _scrollToBottom();

    await _sendToServer(message: message, filePath: filePath);
  }

  Future<void> _sendToServer({String? message, String? filePath}) async {
    try {
      isSending.value = true;

      FormData? formData;
      Map<String, dynamic>? jsonData;

      if (filePath != null) {
        formData = FormData.fromMap({
          'message_type': 'image',
          'file': await MultipartFile.fromFile(filePath),
        });
      } else {
        jsonData = {'message_type': 'text', 'message': message};
      }

      final response = filePath != null
          ? await DioHelper.postForm(
              url: EndPoints.chat,
              data: formData!,
              sendAuthToken: true,
              showErrors: false,
              silent: true,
            )
          : await DioHelper.postData(
              url: EndPoints.chat,
              data: jsonData!,
              sendAuthToken: true,
              showErrors: false,
              silent: true,
            );

      if (response.statusCode == 200) {
        final chatResponse = ChatResponse.fromJson(response.data);

        if (chatResponse.success) {
          currentChat.value = chatResponse.chat;
          _processNewServerMessages(chatResponse.messages);
        }
      }
    } catch (e) {
      printLog('Error sending message: $e');

      Future.delayed(const Duration(milliseconds: 800), () {
        messages.add(
          ChatMessage(
            text: 'تم استلام رسالتك. سيرد عليك أحد مهندسينا الزراعيين قريباً.',
            isUser: false,
            time: _getCurrentTime(),
          ),
        );
        _scrollToBottom();
      });
    } finally {
      isSending.value = false;
    }
  }

  void _processNewServerMessages(List<ChatMessageModel> serverMessages) {
    for (var serverMessage in serverMessages) {
      if (serverMessage.senderType == 'admin') {
        final alreadyExists = messages.any(
          (msg) => msg.text == serverMessage.content && !msg.isUser,
        );

        if (!alreadyExists) {
          final type = (serverMessage.messageType).toLowerCase();

          messages.add(
            ChatMessage(
              text: serverMessage.content,
              isUser: false,
              time: _formatServerTime(serverMessage.createdAt),
              messageType: type,
              imageUrl: (type == 'image' || type == 'file') ? serverMessage.content : null,
              isLocalImage: false,
            ),
          );
        }
      }
    }

    _scrollToBottom();
  }

  Future<void> pickAndSendFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        await sendMessage('', filePath: result.files.single.path);
      }
    } catch (e) {
      printLog('Error picking file: $e');
      CustomSnackbar.error('فشل اختيار الملف');
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return DateFormat('hh:mm a', 'ar').format(now);
  }

  String _formatServerTime(String serverTime) {
    try {
      final dateTime = DateTime.parse(serverTime);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (messageDate == today) {
        return DateFormat('hh:mm a', 'ar').format(dateTime);
      } else if (messageDate == today.subtract(const Duration(days: 1))) {
        return 'أمس ${DateFormat('hh:mm a', 'ar').format(dateTime)}';
      } else {
        return DateFormat('dd/MM hh:mm a', 'ar').format(dateTime);
      }
    } catch (e) {
      return _getCurrentTime();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
