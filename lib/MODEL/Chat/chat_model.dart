class CommonQuestionModel {
  final int id;
  final String question;
  final String answer;

  CommonQuestionModel({required this.id, required this.question, required this.answer});

  factory CommonQuestionModel.fromJson(Map<String, dynamic> json) {
    return CommonQuestionModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}

class CommonQuestionsResponse {
  final bool success;
  final String message;
  final List<CommonQuestionModel> data;

  CommonQuestionsResponse({required this.success, required this.message, required this.data});

  factory CommonQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return CommonQuestionsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => CommonQuestionModel.fromJson(e)).toList() ?? [],
    );
  }
}

class ChatModel {
  final int id;
  final int userId;
  final String lastMessageAt;
  final int unreadCountUser;
  final int unreadCountAdmin;
  final String createdAt;
  final String updatedAt;

  ChatModel({
    required this.id,
    required this.userId,
    required this.lastMessageAt,
    required this.unreadCountUser,
    required this.unreadCountAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      lastMessageAt: json['last_message_at'] ?? '',
      unreadCountUser: json['unread_count_user'] ?? 0,
      unreadCountAdmin: json['unread_count_admin'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class ChatMessageModel {
  final int id;
  final int chatId;
  final int senderId;
  final String senderType;
  final String messageType;
  final String content;
  final String createdAt;
  final String updatedAt;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderType,
    required this.messageType,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? 0,
      chatId: json['chat_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      senderType: json['sender_type'] ?? 'user',
      messageType: json['message_type'] ?? 'text',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class ChatResponse {
  final bool success;
  final ChatModel chat;
  final List<ChatMessageModel> messages;

  ChatResponse({required this.success, required this.chat, required this.messages});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] ?? false,
      chat: ChatModel.fromJson(json['chat'] ?? {}),
      messages:
          (json['messages'] as List?)?.map((e) => ChatMessageModel.fromJson(e)).toList() ?? [],
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;
  final String messageType;
  final bool isCommonQuestion;
  final String? imageUrl;
  final bool isLocalImage;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.messageType = 'text',
    this.isCommonQuestion = false,
    this.imageUrl,
    this.isLocalImage = false,
  });
}
