import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/post_service.dart';

class SocialCirclePage extends StatefulWidget {
  const SocialCirclePage({super.key});

  @override
  State<SocialCirclePage> createState() => _SocialCirclePageState();
}

class _SocialCirclePageState extends State<SocialCirclePage> {
  List<dynamic> _posts = [];
  bool _isLoading = true;
  int _currentUserId = 1;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final posts = await PostService.getAllPosts();
      // 添加默认数据
      if (posts.isEmpty) {
        _posts = [
          {
            'id': 1,
            'content': '推荐一部最近看的动漫，剧情非常精彩！',
            'userId': 1,
            'likes': 23,
            'comments': 5
          },
          {
            'id': 2,
            'content': '分享一下我的插画作品，希望大家喜欢',
            'userId': 2,
            'likes': 45,
            'comments': 12
          },
          {
            'id': 3,
            'content': '今天学习日语的进度，大家一起加油！',
            'userId': 3,
            'likes': 18,
            'comments': 8
          },
          {
            'id': 4,
            'content': '求推荐一些好看的番剧',
            'userId': 1,
            'likes': 15,
            'comments': 20
          }
        ];
      } else {
        _posts = posts;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // 即使出错也显示默认数据
      setState(() {
        _posts = [
          {
            'id': 1,
            'content': '推荐一部最近看的动漫，剧情非常精彩！',
            'userId': 1,
            'likes': 23,
            'comments': 5
          },
          {
            'id': 2,
            'content': '分享一下我的插画作品，希望大家喜欢',
            'userId': 2,
            'likes': 45,
            'comments': 12
          }
        ];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('次元社交圈',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 功能按钮
          Row(
            children: [
              _buildSocialBtn(Icons.group_add, '创建小组', context),
              const SizedBox(width: 16),
              _buildSocialBtn(Icons.message, '私信', context),
              const SizedBox(width: 16),
              _buildSocialBtn(Icons.event, '漫展活动', context),
            ],
          ),
          const SizedBox(height: 20),
          // 帖子列表
          const Text('最新动态',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.forum, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('暂无帖子数据',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView(
                        children: _posts.map((post) => _buildPostItem(post)).toList(),
                      ),
          ),
        ],
      ),
    );
  }

  // 社交功能按钮
  Widget _buildSocialBtn(IconData icon, String text, BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[100],
          foregroundColor: Colors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _showTip(context, '$text待开发'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 4),
            Text(text, style: const TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }

  // 帖子条目
  Widget _buildPostItem(dynamic post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Text('用户${post['userId']}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Text(post['content'] ?? '暂无内容',
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.pink),
                    onPressed: () => _likePost(post['id'])),
                Text('${post['likes'] ?? 0}',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 16),
                IconButton(
                    icon: const Icon(Icons.comment_outlined, color: Colors.grey),
                    onPressed: () => _addComment(post['id'])),
                Text('${post['comments'] ?? 0}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 点赞帖子
  Future<void> _likePost(int id) async {
    try {
      await PostService.likePost(id);
      _loadPosts();
    } catch (e) {
      _showTip(context, '点赞失败');
    }
  }

  // 评论帖子
  Future<void> _addComment(int id) async {
    _commentController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加评论'),
        content: TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: '输入评论内容',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              if (_commentController.text.trim().isEmpty) {
                Navigator.pop(context);
                return;
              }
              try {
                await PostService.addComment(id, _currentUserId);
                Navigator.pop(context);
                _loadPosts();
                _showTip(context, '评论成功');
              } catch (e) {
                _showTip(context, '评论失败');
              }
            },
            child: const Text('发送'),
          ),
        ],
      ),
    );
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }
}
