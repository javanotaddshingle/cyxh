import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/workshop_service.dart';
import 'package:ciyuanxinghe_mod/pages/drawing_create_page.dart';
import 'package:ciyuanxinghe_mod/pages/animation_create_page.dart';
import 'package:ciyuanxinghe_mod/pages/novel_create_page.dart';
import 'package:ciyuanxinghe_mod/pages/music_create_page.dart';

class CreateWorkshopPage extends StatefulWidget {
  const CreateWorkshopPage({super.key});

  @override
  State<CreateWorkshopPage> createState() => _CreateWorkshopPageState();
}

class _CreateWorkshopPageState extends State<CreateWorkshopPage> {
  List<dynamic> _workshops = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkshops();
  }

  Future<void> _loadWorkshops() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final workshops = await WorkshopService.getAllWorkshops();
      // 添加默认数据
      if (workshops.isEmpty) {
        _workshops = [
          {
            'id': 1,
            'name': '绘画基础班',
            'category': '绘画',
            'description': '学习绘画基础技巧，适合初学者',
            'participants': 25
          },
          {
            'id': 2,
            'name': '剧本创作',
            'category': '写作',
            'description': '学习动漫剧本创作技巧',
            'participants': 18
          },
          {
            'id': 3,
            'name': 'Cosplay制作',
            'category': '手工',
            'description': '学习Cosplay服装制作',
            'participants': 32
          }
        ];
      } else {
        _workshops = workshops;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // 即使出错也显示默认数据
      setState(() {
        _workshops = [
          {
            'id': 1,
            'name': '绘画基础班',
            'category': '绘画',
            'description': '学习绘画基础技巧，适合初学者',
            'participants': 25
          },
          {
            'id': 2,
            'name': '剧本创作',
            'category': '写作',
            'description': '学习动漫剧本创作技巧',
            'participants': 18
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
          const Text('创作工坊',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 创作工具
          const Text('创作工具',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToolCard(Icons.brush, '绘画创作', '笔刷+图层+特效'),
              const SizedBox(width: 12),
              _buildToolCard(Icons.animation, '动画制作', '骨骼动画+关键帧'),
              const SizedBox(width: 12),
              _buildToolCard(Icons.book, '小说写作', '灵感素材+剧情大纲'),
              const SizedBox(width: 12),
              _buildToolCard(Icons.music_note, '音乐创作', '虚拟乐器+音频编辑'),
            ],
          ),
          const SizedBox(height: 20),
          // 工坊列表
          const Text('热门创作工坊',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _workshops.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.workspaces_outlined, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('暂无工坊数据',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView(
                        children: _workshops.map((workshop) => _buildWorkshopItem(workshop)).toList(),
                      ),
          ),
        ],
      ),
    );
  }

  // 创作工具卡片
  Widget _buildToolCard(IconData icon, String title, String desc) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            if (title == '绘画创作') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrawingCreatePage()),
              );
            } else if (title == '动画制作') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimationCreatePage()),
              );
            } else if (title == '小说写作') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NovelCreatePage()),
              );
            } else if (title == '音乐创作') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MusicCreatePage()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28, color: Colors.pink),
                const SizedBox(height: 6),
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 工坊条目
  Widget _buildWorkshopItem(dynamic workshop) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.workspaces, color: Colors.pink, size: 40),
        title: Text(workshop['name'] ?? '未命名工坊',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('分类：${workshop['category'] ?? '未分类'}',
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
            Text('${workshop['description'] ?? '暂无描述'}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: TextButton(
            onPressed: () => _joinWorkshop(workshop['id']),
            child: const Text('加入',
                style: TextStyle(color: Colors.pink, fontSize: 14))),
      ),
    );
  }

  // 加入工坊
  Future<void> _joinWorkshop(int id) async {
    try {
      await WorkshopService.joinWorkshop(id);
      _showTip(context, '加入成功');
      _loadWorkshops();
    } catch (e) {
      _showTip(context, '加入失败');
    }
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }
}
