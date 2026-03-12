import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/work_service.dart';

class WorksShowPage extends StatefulWidget {
  const WorksShowPage({super.key});

  @override
  State<WorksShowPage> createState() => _WorksShowPageState();
}

class _WorksShowPageState extends State<WorksShowPage> {
  List<dynamic> _works = [];
  bool _isLoading = true;
  String _selectedCategory = '全部作品';
  int _currentUserId = 1;

  @override
  void initState() {
    super.initState();
    _loadWorks();
  }

  Future<void> _loadWorks() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<dynamic> works;
      if (_selectedCategory == '全部作品') {
        works = await WorkService.getAllWorks();
      } else {
        works = await WorkService.getWorksByCategory(_selectedCategory);
      }
      // 添加默认数据
      if (works.isEmpty) {
        works = [
          {
            'id': 1,
            'title': '鬼灭之刃',
            'category': '动画',
            'userId': 1,
            'likes': 120,
            'views': 500
          },
          {
            'id': 2,
            'title': '你的名字',
            'category': '动画',
            'userId': 2,
            'likes': 98,
            'views': 350
          },
          {
            'id': 3,
            'title': '进击的巨人',
            'category': '动画',
            'userId': 1,
            'likes': 156,
            'views': 620
          },
          {
            'id': 4,
            'title': '夏目友人帐',
            'category': '动画',
            'userId': 3,
            'likes': 89,
            'views': 280
          },
          {
            'id': 5,
            'title': 'Re:从零开始',
            'category': '动画',
            'userId': 2,
            'likes': 112,
            'views': 410
          }
        ];
      }
      setState(() {
        _works = works;
        _isLoading = false;
      });
    } catch (e) {
      // 即使出错也显示默认数据
      setState(() {
        _works = [
          {
            'id': 1,
            'title': '鬼灭之刃',
            'category': '动画',
            'userId': 1,
            'likes': 120,
            'views': 500
          },
          {
            'id': 2,
            'title': '你的名字',
            'category': '动画',
            'userId': 2,
            'likes': 98,
            'views': 350
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
          const Text('作品展示广场',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // 分类+排行榜
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(
                      value: '全部作品',
                      child: Text('全部作品',
                          style: TextStyle(fontSize: 14))),
                  DropdownMenuItem(
                      value: '漫画',
                      child: Text('漫画', style: TextStyle(fontSize: 14))),
                  DropdownMenuItem(
                      value: '动画',
                      child: Text('动画', style: TextStyle(fontSize: 14))),
                  DropdownMenuItem(
                      value: '小说',
                      child: Text('小说', style: TextStyle(fontSize: 14))),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                    _loadWorks();
                  }
                },
              ),
              TextButton(
                onPressed: () => _showTip(context, '排行榜待开发'),
                child: const Text('排行榜 >',
                    style:
                        TextStyle(color: Colors.pink, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 作品列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _works.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('暂无作品数据',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView(
                        children: _works.map((work) => _buildWorkItem(work)).toList(),
                      ),
          ),
        ],
      ),
    );
  }

  // 作品条目
  Widget _buildWorkItem(dynamic work) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(work['title'],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('作者：用户${work['userId']}',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14)),
                const SizedBox(width: 16),
                Text('分类：${work['category']}',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.pink),
                    onPressed: () => _likeWork(work['id'])),
                Text('${work['likes']}', style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 16),
                IconButton(
                    icon: const Icon(Icons.comment_bank_outlined,
                        color: Colors.grey),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 点赞作品
  Future<void> _likeWork(int id) async {
    try {
      await WorkService.likeWork(id, _currentUserId);
      _loadWorks();
    } catch (e) {
      _showTip(context, '点赞失败');
    }
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }
}
