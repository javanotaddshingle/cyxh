import 'package:flutter/material.dart';

class MusicCreatePage extends StatefulWidget {
  const MusicCreatePage({super.key});

  @override
  State<MusicCreatePage> createState() => _MusicCreatePageState();
}

class _MusicCreatePageState extends State<MusicCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedInstrument = '钢琴';
  List<String> _tracks = ['旋律', '和声', '节奏', '贝斯'];

  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('音乐创作'),
        actions: [
          TextButton(
            onPressed: () => _saveMusic(),
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // 音乐编辑区域
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isPlaying ? Icons.pause_circle : Icons.play_circle,
                          size: 64,
                          color: _isPlaying ? Colors.pink : Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _isPlaying ? '正在播放: $_selectedInstrument' : '点击播放按钮开始预览',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 音乐控制面板
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 基本信息
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: '音乐标题',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: '音乐描述',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // 乐器选择
                const Text('虚拟乐器', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: _selectedInstrument,
                  items: ['钢琴', '吉他', '小提琴', '鼓', '合成器'].map((instrument) {
                    return DropdownMenuItem(
                      value: instrument,
                      child: Text(instrument),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedInstrument = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                // 音轨管理
                const Text('音轨管理', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  children: _tracks.map((track) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(track),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // 音乐控制
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous),
                      label: const Text('上一曲'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                        if (_isPlaying) {
                          // 模拟播放3秒后自动停止
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              _isPlaying = false;
                            });
                          });
                        }
                      },
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      label: Text(_isPlaying ? '暂停' : '播放'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next),
                      label: const Text('下一曲'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveMusic() {
    // 保存音乐逻辑
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
