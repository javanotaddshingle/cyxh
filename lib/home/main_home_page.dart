import 'package:flutter/material.dart';
import '../pages/works_show_page.dart';
import '../pages/create_workshop_page.dart';
import '../pages/trade_market_page.dart';
import '../pages/social_circle_page.dart';
import '../pages/language_learn_page.dart';
import '../pages/personal_center_page.dart';
import '../pages/search_page.dart';
import '../pages/message_center_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0; // 当前选中的Tab索引

  // 5大核心页面
  final List<Widget> _pages = const [
    WorksShowPage(), // 作品广场
    CreateWorkshopPage(), // 创作工坊
    TradeMarketPage(), // 交易市场
    SocialCirclePage(), // 次元社交
    LanguageLearnPage(), // 语言学习
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部栏：搜索+消息+头像（无图片依赖）
      appBar: AppBar(
        title: const Text('次元星河'),
        actions: [
          // 搜索按钮
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          // 消息按钮
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessageCenterPage()),
              );
            },
          ),
          // 头像（用文字替代图片，无资源依赖）
          IconButton(
            icon: const CircleAvatar(
              child: Text('hi'), // 文字头像，无需图片
              radius: 16,
            ),
            onPressed: () {
              // 跳个人中心
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalCenterPage()),
              );
            },
          ),
        ],
      ),
      // 主体内容
      body: _pages[_currentIndex],
      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: '作品广场'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: '创作工坊'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '交易市场'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '次元社交'),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: '语言学习'),
        ],
      ),
    );
  }

  // 通用提示弹窗
  void _showTip(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }
}
