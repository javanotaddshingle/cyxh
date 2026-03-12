import 'package:flutter/material.dart';

class AnimationCreatePage extends StatefulWidget {
  const AnimationCreatePage({super.key});

  @override
  State<AnimationCreatePage> createState() => _AnimationCreatePageState();
}

class _AnimationCreatePageState extends State<AnimationCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _currentFrame = 1;
  int _totalFrames = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画制作'),
        actions: [
          TextButton(
            onPressed: () => _saveAnimation(),
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // 动画预览区域
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
                        const Icon(Icons.animation, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('动画制作功能开发中...', style: TextStyle(color: Colors.grey[600])),
                        const SizedBox(height: 16),
                        Text('当前帧: $_currentFrame / $_totalFrames', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 动画控制面板
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
                    labelText: '动画标题',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: '动画描述',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                // 时间轴
                const Text('时间轴', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _totalFrames,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentFrame = index + 1;
                          });
                        },
                        child: Container(
                          width: 40,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _currentFrame == index + 1 ? Colors.pink[100] : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text('${index + 1}', style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // 动画控制
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _prevFrame(),
                      icon: const Icon(Icons.skip_previous),
                      label: const Text('上一帧'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _playAnimation(),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('播放'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _nextFrame(),
                      icon: const Icon(Icons.skip_next),
                      label: const Text('下一帧'),
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

  void _prevFrame() {
    if (_currentFrame > 1) {
      setState(() {
        _currentFrame--;
      });
    }
  }

  void _nextFrame() {
    if (_currentFrame < _totalFrames) {
      setState(() {
        _currentFrame++;
      });
    }
  }

  void _playAnimation() {
    // 简单的动画播放逻辑
    setState(() {
      _currentFrame = 1;
    });
    // 模拟动画播放
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_currentFrame < _totalFrames) {
        setState(() {
          _currentFrame++;
        });
        _playAnimation();
      }
    });
  }

  void _saveAnimation() {
    // 保存动画逻辑
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
