import 'package:ciyuanxinghe_mod/api/api_service.dart';

class MessageService {
  // 发送消息
  static Future<dynamic> sendMessage(Map<String, dynamic> message) async {
    return await ApiService.post('/messages', message);
  }

  // 获取用户消息列表
  static Future<List<dynamic>> getUserMessages(int userId) async {
    return await ApiService.get('/messages/user/$userId');
  }

  // 获取对话记录
  static Future<List<dynamic>> getConversation(int userId1, int userId2) async {
    return await ApiService.get('/messages/conversation?userId1=$userId1&userId2=$userId2');
  }

  // 获取未读消息数量
  static Future<dynamic> getUnreadCount(int userId) async {
    return await ApiService.get('/messages/user/$userId/unread-count');
  }

  // 标记消息为已读
  static Future<dynamic> markAsRead(int id) async {
    return await ApiService.post('/messages/$id/read', {});
  }

  // 标记所有消息为已读
  static Future<dynamic> markAllAsRead(int userId) async {
    return await ApiService.post('/messages/user/$userId/read-all', {});
  }
}
