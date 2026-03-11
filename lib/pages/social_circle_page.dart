import 'package:flutter/material.dart';

class SocialCirclePage extends StatelessWidget {
  const SocialCirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('次元社交圈',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)),
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
          // 兴趣小组
          const Text('热门兴趣小组',
              style: TextStyle(
                  fontSize: 38, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildGroupItem('原神交流群', '2345人', '璃月/蒙德剧情讨论'),
                _buildGroupItem('鬼灭之刃粉丝团', '1890人', '同人创作/角色分析'),
                _buildGroupItem('日语动漫学习社', '987人', '动漫台词/日语交流'),
              ],
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
            Icon(icon, size: 38),
            const SizedBox(height: 4),
            Text(text, style: const TextStyle(fontSize: 32))
          ],
        ),
      ),
    );
  }

  // 兴趣小组条目
  Widget _buildGroupItem(String name, String count, String desc) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 93, 37, 57),
          child: Icon(Icons.people, color: Colors.pink, size: 42)),
      title: Text(name, style: const TextStyle(fontSize: 36)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 32)),
          Text(desc,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 32)),
        ],
      ),
      trailing: TextButton(
          onPressed: () {},
          child: const Text('加入',
              style: TextStyle(color: Colors.pink, fontSize: 32))),
    );
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)),
    ));
  }
}
