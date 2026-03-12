import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/course_service.dart';

class LanguageLearnPage extends StatefulWidget {
  const LanguageLearnPage({super.key});

  @override
  State<LanguageLearnPage> createState() => _LanguageLearnPageState();
}

class _LanguageLearnPageState extends State<LanguageLearnPage> {
  List<dynamic> _courses = [];
  bool _isLoading = true;
  String _selectedLanguage = '全部';

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<dynamic> courses;
      if (_selectedLanguage == '全部') {
        courses = await CourseService.getAllCourses();
      } else {
        courses = await CourseService.getCoursesByLanguage(_selectedLanguage);
      }
      // 添加默认数据
      if (courses.isEmpty) {
        courses = [
          {
            'id': 1,
            'title': '日语五十音',
            'language': '日语',
            'enrollments': 1200
          },
          {
            'id': 2,
            'title': '动漫日语',
            'language': '日语',
            'enrollments': 850
          },
          {
            'id': 3,
            'title': '日语台词赏析',
            'language': '日语',
            'enrollments': 620
          },
          {
            'id': 4,
            'title': '二次元插画入门',
            'language': '英语',
            'enrollments': 480
          }
        ];
      }
      setState(() {
        _courses = courses;
        _isLoading = false;
      });
    } catch (e) {
      // 即使出错也显示默认数据
      setState(() {
        _courses = [
          {
            'id': 1,
            'title': '日语五十音',
            'language': '日语',
            'enrollments': 1200
          },
          {
            'id': 2,
            'title': '动漫日语',
            'language': '日语',
            'enrollments': 850
          }
        ];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('语言学习空间',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 语言选择
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['全部', '日语', '韩语', '英语'].map((lang) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang;
                    });
                    _loadCourses();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _selectedLanguage == lang ? Colors.pink[100] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        Text(lang, style: const TextStyle(fontSize: 14)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // 语言课程
          Expanded(
            flex: 1,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _courses.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('暂无课程数据',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      )
                    : GridView.count(
                        crossAxisCount: 3,
                        children: _courses.map((course) => _buildLangCard(course)).toList(),
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
  Widget _buildLangCard(dynamic course) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language, size: 36, color: Colors.pink),
            const SizedBox(height: 8),
            Text(course['language'],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(course['title'],
                style:
                    const TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('${course['enrollments']}人报名',
                style:
                    const TextStyle(color: Colors.grey, fontSize: 12),
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
            Icon(icon, color: Colors.pink, size: 20),
            const SizedBox(width: 4),
            Text(text,
                style:
                    const TextStyle(color: Colors.pink, fontSize: 14))
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
