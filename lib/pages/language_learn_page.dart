import 'package:flutter/material.dart';

class LanguageLearnPage extends StatelessWidget {
  const LanguageLearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('语言学习空间',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 语言课程
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                _buildLangCard('日语', '鬼灭之刃/原神'),
                _buildLangCard('韩语', '韩国动漫/韩剧'),
                _buildLangCard('英语', '欧美动漫/游戏'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 功能按钮
          Row(
            children: [
              _buildLearnBtn('多语种交流区', Icons.chat, context),
              const SizedBox(width: 16),
              _buildLearnBtn('配音练习', Icons.mic, context),
              const SizedBox(width: 16),
              _buildLearnBtn('AI语言助手', Icons.assistant, context),
            ],
          ),
        ],
      ),
    );
  }

  // 语言课程卡片
  Widget _buildLangCard(String lang, String material) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language, size: 54, color: Colors.pink),
            const SizedBox(height: 8),
            Text(lang,
                style: const TextStyle(
                    fontSize: 38, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(material,
                style:
                    const TextStyle(color: Colors.grey, fontSize: 30),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // 学习功能按钮
  Widget _buildLearnBtn(String text, IconData icon, BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.pink),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => _showTip(context, '$text待开发'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.pink, size: 34),
            const SizedBox(width: 4),
            Text(text,
                style:
                    const TextStyle(color: Colors.pink, fontSize: 32))
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
