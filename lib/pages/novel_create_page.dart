import 'package:flutter/material.dart';

class NovelCreatePage extends StatefulWidget {
  const NovelCreatePage({super.key});

  @override
  State<NovelCreatePage> createState() => _NovelCreatePageState();
}

class _NovelCreatePageState extends State<NovelCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _outlineController = TextEditingController();
  String _selectedGenre = '奇幻';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('小说写作'),
        actions: [
          TextButton(
            onPressed: () => _saveNovel(),
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // 写作区域
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 左侧内容编辑
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          hintText: '开始写作...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 右侧大纲
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('剧情大纲', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _outlineController,
                              decoration: const InputDecoration(
                                hintText: '添加大纲...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 工具栏
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 基本信息
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: '小说标题',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _selectedGenre,
                      items: ['奇幻', '科幻', '言情', '武侠', '悬疑'].map((genre) {
                        return DropdownMenuItem(
                          value: genre,
                          child: Text(genre),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedGenre = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 写作工具
                const Text('写作工具', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildToolButton('灵感素材', Icons.lightbulb),
                    _buildToolButton('人物设定', Icons.person),
                    _buildToolButton('世界观', Icons.public),
                    _buildToolButton('章节管理', Icons.book),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // 工具功能
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.pink),
            ),
          ),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _saveNovel() {
    // 保存小说逻辑
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入小说标题')),
      );
      return;
    }
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入小说内容')),
      );
      return;
    }
    // 模拟保存成功
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('小说《${_titleController.text}》保存成功')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _outlineController.dispose();
    super.dispose();
  }
}
