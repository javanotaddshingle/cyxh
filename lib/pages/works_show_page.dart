import 'package:flutter/material.dart';

class WorksShowPage extends StatelessWidget {
  const WorksShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('作品展示广场',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // 分类+排行榜
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: '全部作品',
                items: const [
                  DropdownMenuItem(
                      value: '全部作品',
                      child: Text('全部作品',
                          style: TextStyle(fontSize: 32))),
                  DropdownMenuItem(
                      value: '漫画',
                      child: Text('漫画', style: TextStyle(fontSize: 32))),
                  DropdownMenuItem(
                      value: '动画',
                      child: Text('动画', style: TextStyle(fontSize: 32))),
                  DropdownMenuItem(
                      value: '小说',
                      child: Text('小说', style: TextStyle(fontSize: 32))),
                ],
                onChanged: (value) {},
              ),
              TextButton(
                onPressed: () => _showTip(context, '排行榜待开发'),
                child: const Text('排行榜 >',
                    style:
                        TextStyle(color: Colors.pink, fontSize: 32)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 作品列表
          Expanded(
            child: ListView(
              children: [
                _buildWorkItem('《鬼灭之刃》同人漫画', '炭治郎的笔', '漫画', 1289),
                _buildWorkItem('《原神》同人动画', '璃月说书人', '动画', 3456),
                _buildWorkItem('《全职高手》同人小说', '叶秋的伞', '小说', 897),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 作品条目
  Widget _buildWorkItem(String title, String author, String type, int like) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('作者：$author',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 34)),
                const SizedBox(width: 16),
                Text('分类：$type',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 34)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.pink),
                    onPressed: () {}),
                Text('$like', style: const TextStyle(fontSize: 32)),
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

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)),
    ));
  }
}
