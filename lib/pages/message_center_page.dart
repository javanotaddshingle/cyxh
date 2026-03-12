import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/message_service.dart';

class MessageCenterPage extends StatefulWidget {
  const MessageCenterPage({super.key});

  @override
  State<MessageCenterPage> createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  List<dynamic> _messages = [];
  bool _isLoading = true;
  int _currentUserId = 1;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final messages = await MessageService.getUserMessages(_currentUserId);
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
        actions: [
          TextButton(
            onPressed: () => _markAllAsRead(),
            child: const Text('全部已读', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _messages.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.message, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('暂无消息', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('U${message['fromUserId']}', style: const TextStyle(fontSize: 12)),
                      ),
                      title: Text('用户${message['fromUserId']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(message['content'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: message['isRead'] == false
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                      onTap: () => _openMessage(message),
                    );
                  },
                ),
    );
  }

  void _openMessage(dynamic message) {
    // 标记为已读
    MessageService.markAsRead(message['id']);
    // 打开消息详情
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('用户${message['fromUserId']}'),
        content: Text(message['content'] ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Future<void> _markAllAsRead() async {
    await MessageService.markAllAsRead(_currentUserId);
    _loadMessages();
  }
}
