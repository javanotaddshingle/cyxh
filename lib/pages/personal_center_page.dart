import 'package:flutter/material.dart';

class PersonalCenterPage extends StatelessWidget {
  const PersonalCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        titleTextStyle: const TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings, size: 38),
              onPressed: () => _showTip(context, '设置待开发'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 个人信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                        child: Text('hi', style: TextStyle(fontSize: 38)),
                        radius: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('次元创作者',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('个性签名：用创作点亮次元世界 ✨',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 34)),
                          TextButton(
                              onPressed: () => _showTip(context, '编辑资料待开发'),
                              child: const Text('编辑资料',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 32))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 功能入口
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildFuncItem('我的作品', Icons.article, context),
                  _buildFuncItem('我的收藏', Icons.favorite, context),
                  _buildFuncItem('我的订单', Icons.shopping_cart, context),
                  _buildFuncItem('我的小组', Icons.group, context),
                  _buildFuncItem('学习记录', Icons.history, context),
                  _buildFuncItem('帮助中心', Icons.help, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 个人中心功能项
  Widget _buildFuncItem(String text, IconData icon, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _showTip(context, '$text待开发'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 54, color: Colors.pink),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 34))
          ],
        ),
      ),
    );
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)),
    ));
  }
}
