import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class DrawingCreatePage extends StatefulWidget {
  const DrawingCreatePage({super.key});

  @override
  State<DrawingCreatePage> createState() => _DrawingCreatePageState();
}

class _DrawingCreatePageState extends State<DrawingCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _selectedTool = '铅笔';
  Color _selectedColor = Colors.black;
  double _brushSize = 2.0;
  List<_DrawingPath> _paths = [];
  _DrawingPath? _currentPath;
  bool _isDrawing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘画创作'),
        actions: [
          TextButton(
            onPressed: () => _saveDrawing(),
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // 作品信息（顶部）
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: '作品标题',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: '分类',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 主要内容区域（不滚动）
          Expanded(
            child: Row(
              children: [
                // 画布区域（占中）
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        _isDrawing = true;
                        _currentPath = _DrawingPath(
                          tool: _selectedTool,
                          color: _selectedTool == '橡皮擦' ? Colors.white : _selectedColor,
                          strokeWidth: _brushSize,
                          points: [details.localPosition],
                        );
                      });
                    },
                    onPanUpdate: (details) {
                      if (_isDrawing && _currentPath != null) {
                        setState(() {
                          _currentPath!.points.add(details.localPosition);
                        });
                      }
                    },
                    onPanEnd: (details) {
                      setState(() {
                        if (_currentPath != null) {
                          _paths.add(_currentPath!);
                          _currentPath = null;
                        }
                        _isDrawing = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: CustomPaint(
                        painter: _DrawingPainter(_paths, _currentPath),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ),
                // 工具面板（右侧）
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.grey[200]!)),
                    color: Colors.grey[50],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 工具选择
                        const Text('绘画工具', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildToolButton('铅笔', Icons.edit),
                            _buildToolButton('橡皮擦', Icons.remove),
                            _buildToolButton('喷枪', Icons.blur_on),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // 颜色选择
                        const Text('颜色', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildColorButton(Colors.black),
                            _buildColorButton(Colors.red),
                            _buildColorButton(Colors.blue),
                            _buildColorButton(Colors.green),
                            _buildColorButton(Colors.yellow),
                            _buildColorButton(Colors.pink),
                            _buildColorButton(Colors.purple),
                            _buildColorButton(Colors.orange),
                            _buildColorButton(Colors.teal),
                            _buildColorButton(Colors.grey),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // 画笔大小
                        const Text('画笔大小', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Slider(
                          value: _brushSize,
                          min: 1.0,
                          max: 20.0,
                          onChanged: (value) {
                            setState(() {
                              _brushSize = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('细'),
                            Text('${_brushSize.toStringAsFixed(1)}px'),
                            const Text('粗'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // 快捷操作
                        const Text('快捷操作', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _paths.clear();
                                  });
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text('清空画布'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[100],
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String tool, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTool = tool;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedTool == tool ? Colors.pink[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: _selectedTool == tool ? Colors.pink : Colors.grey),
            const SizedBox(height: 4),
            Text(tool, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: _selectedColor == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _saveDrawing() {
    // 保存绘画逻辑
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}

class _DrawingPath {
  final String tool;
  final Color color;
  final double strokeWidth;
  final List<Offset> points;
  final int randomSeed; // 随机种子，确保每次绘制时使用相同的随机序列

  _DrawingPath({
    required this.tool,
    required this.color,
    required this.strokeWidth,
    required this.points,
  }) : randomSeed = DateTime.now().millisecondsSinceEpoch;
}

class _DrawingPainter extends CustomPainter {
  final List<_DrawingPath> paths;
  final _DrawingPath? currentPath;

  _DrawingPainter(this.paths, this.currentPath);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制已完成的路径
    for (var path in paths) {
      _drawPath(canvas, path);
    }
    // 绘制当前正在绘制的路径
    if (currentPath != null) {
      _drawPath(canvas, currentPath!);
    }
  }

  void _drawPath(Canvas canvas, _DrawingPath path) {
    if (path.points.length < 2) return;

    Paint paint = Paint()
      ..color = path.color
      ..strokeWidth = path.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (path.tool == '喷枪') {
      // 喷枪效果：在路径上绘制多个随机分布的小圆点
      // 使用固定的随机种子，确保每次绘制时使用相同的随机序列
      math.Random random = math.Random(path.randomSeed);
      
      for (int i = 0; i < path.points.length - 1; i++) {
        Offset p1 = path.points[i];
        Offset p2 = path.points[i + 1];
        double distance = (p2 - p1).distance;
        int steps = (distance / 3).ceil(); // 增加步数以获得更密集的墨点
        
        for (int j = 0; j < steps; j++) {
          double t = j / steps;
          Offset point = Offset(
            p1.dx + (p2.dx - p1.dx) * t,
            p1.dy + (p2.dy - p1.dy) * t,
          );
          
          // 绘制多个随机分布的圆点模拟喷枪效果
          for (int k = 0; k < 5; k++) { // 增加墨点数量
            // 随机偏移
            double randomX = (random.nextDouble() - 0.5) * path.strokeWidth * 2;
            double randomY = (random.nextDouble() - 0.5) * path.strokeWidth * 2;
            Offset randomPoint = Offset(point.dx + randomX, point.dy + randomY);
            
            // 随机大小
            double radius = path.strokeWidth * (0.3 + random.nextDouble() * 0.7);
            
            // 随机透明度
            double opacity = 0.2 + random.nextDouble() * 0.3;
            
            canvas.drawCircle(randomPoint, radius, paint..color = path.color.withOpacity(opacity));
          }
        }
      }
    } else {
      // 普通画笔和橡皮擦效果
      for (int i = 0; i < path.points.length - 1; i++) {
        canvas.drawLine(path.points[i], path.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
