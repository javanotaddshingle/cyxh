import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/work_service.dart';
import 'package:ciyuanxinghe_mod/api/trade_service.dart';
import 'package:ciyuanxinghe_mod/api/course_service.dart';
import 'package:ciyuanxinghe_mod/api/workshop_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _works = [];
  List<dynamic> _trades = [];
  List<dynamic> _courses = [];
  List<dynamic> _workshops = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  Future<void> _search(String keyword) async {
    if (keyword.isEmpty) return;
    
    try {
      setState(() {
        _isLoading = true;
        _hasSearched = true;
      });
      
      final works = await WorkService.searchWorks(keyword);
      final trades = await TradeService.searchTrades(keyword);
      final courses = await CourseService.searchCourses(keyword);
      final workshops = await WorkshopService.searchWorkshops(keyword);
      
      setState(() {
        _works = works;
        _trades = trades;
        _courses = courses;
        _workshops = workshops;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showTip(context, '搜索失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '搜索作品、交易、课程、工坊...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: _search,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _search(_searchController.text),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_hasSearched
              ? const Center(
                  child: Text('输入关键词开始搜索',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 作品结果
                        if (_works.isNotEmpty) ...[
                          const Text('作品',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ..._works.map((work) => _buildResultItem(
                                work['title'] ?? '未命名作品',
                                work['category'] ?? '未分类',
                                Icons.article,
                              )),
                          const SizedBox(height: 16),
                        ],
                        // 交易结果
                        if (_trades.isNotEmpty) ...[
                          const Text('交易',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ..._trades.map((trade) => _buildResultItem(
                                trade['title'] ?? '未命名交易',
                                '¥${trade['price'] ?? 0}',
                                Icons.shopping_cart,
                              )),
                          const SizedBox(height: 16),
                        ],
                        // 课程结果
                        if (_courses.isNotEmpty) ...[
                          const Text('课程',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ..._courses.map((course) => _buildResultItem(
                                course['title'] ?? '未命名课程',
                                course['language'] ?? '未分类',
                                Icons.school,
                              )),
                          const SizedBox(height: 16),
                        ],
                        // 工坊结果
                        if (_workshops.isNotEmpty) ...[
                          const Text('工坊',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ..._workshops.map((workshop) => _buildResultItem(
                                workshop['name'] ?? '未命名工坊',
                                workshop['category'] ?? '未分类',
                                Icons.workspaces,
                              )),
                          const SizedBox(height: 16),
                        ],
                        // 无结果
                        if (_works.isEmpty &&
                            _trades.isEmpty &&
                            _courses.isEmpty &&
                            _workshops.isEmpty)
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off, size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text('未找到相关结果',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildResultItem(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        onTap: () {},
      ),
    );
  }

  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 14)),
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
