import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/work_service.dart';
import 'package:ciyuanxinghe_mod/api/trade_service.dart';
import 'package:ciyuanxinghe_mod/api/course_service.dart';
import 'package:ciyuanxinghe_mod/api/workshop_service.dart';

class PersonalCenterPage extends StatefulWidget {
  const PersonalCenterPage({super.key});

  @override
  State<PersonalCenterPage> createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  int _worksCount = 0;
  int _tradesCount = 0;
  int _coursesCount = 0;
  int _workshopsCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      // 假设当前用户ID为1
      const userId = 1;
      final works = await WorkService.getWorksByUserId(userId);
      final trades = await TradeService.getTradesByUserId(userId);
      final courses = await CourseService.getCoursesByUserId(userId);
      final workshops = await WorkshopService.getWorkshopsByUserId(userId);
      
      setState(() {
        _worksCount = works.length;
        _tradesCount = trades.length;
        _coursesCount = courses.length;
        _workshopsCount = workshops.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings, size: 24),
              onPressed: () => _showTip(context, '设置待开发'))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                              child: Text('hi', style: TextStyle(fontSize: 16)),
                              radius: 30),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('次元创作者',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text('个性签名：用创作点亮次元世界 ✨',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14)),
                                TextButton(
                                    onPressed: () => _showTip(context, '编辑资料待开发'),
                                    child: const Text('编辑资料',
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontSize: 14))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 数据统计
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('作品', _worksCount),
                      _buildStatItem('交易', _tradesCount),
                      _buildStatItem('课程', _coursesCount),
                      _buildStatItem('工坊', _workshopsCount),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 功能入口
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        _buildFuncItem('我的作品', Icons.article, _worksCount, context),
                        _buildFuncItem('我的收藏', Icons.favorite, 0, context),
                        _buildFuncItem('我的订单', Icons.shopping_cart, _tradesCount, context),
                        _buildFuncItem('我的小组', Icons.group, _workshopsCount, context),
                        _buildFuncItem('学习记录', Icons.history, _coursesCount, context),
                        _buildFuncItem('帮助中心', Icons.help, 0, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // 统计项
  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text('$count',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  // 个人中心功能项
  Widget _buildFuncItem(String text, IconData icon, int count, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _showTip(context, '$text功能待开发'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Icon(icon, size: 36, color: Colors.pink),
                if (count > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }

  // 提示弹窗
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }
}
