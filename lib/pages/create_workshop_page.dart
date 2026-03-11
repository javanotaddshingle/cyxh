import 'package:flutter/material.dart';

class CreateWorkshopPage extends StatelessWidget {
  const CreateWorkshopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('创作工坊',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 创作工具网格
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCard(Icons.brush, '绘画创作', '笔刷+图层+特效'),
                _buildCard(Icons.animation, '动画制作', '骨骼动画+关键帧'),
                _buildCard(Icons.book, '小说写作', '灵感素材+剧情大纲'),
                _buildCard(Icons.music_note, '音乐创作', '虚拟乐器+音频编辑'),
                _buildCard(Icons.auto_awesome, 'AI辅助创作', '生成角色/故事/配乐',
                    Colors.pink[100]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 创作工具卡片
  Widget _buildCard(IconData icon, String title, String desc, [Color? color]) {
    return Card(
      elevation: 2,
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 66, color: Colors.pink),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 38, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
