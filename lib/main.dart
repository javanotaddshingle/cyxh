import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimePlatformApp());
}

// 应用入口
class AnimePlatformApp extends StatelessWidget {
  const AnimePlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '次元星河',
      theme: ThemeData(
        primarySwatch: Colors.pink, // 二次元风格主色
        scaffoldBackgroundColor: Colors.grey[50],
        // 修改：Web端明确指定中文字体栈，适配所有渲染模式
        fontFamily: kIsWeb
            ? "Microsoft YaHei, PingFang SC, sans-serif"
            // Windows用微软雅黑，macOS/iOS用苹方，兜底用无衬线字体
            : null, // 非Web环境保持默认字体，不影响移动端
        // 新增：统一调大AppBar标题字体（原33→38）
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 38, // 再调大5号
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 212, 75, 178), // 颜色不变
          ),
        ),
      ),
      home: const MainHomePage(),
      debugShowCheckedModeBanner: false, // 隐藏调试水印
    );
  }
}

// 首页（底部导航主入口）
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
            onPressed: () => _showTip('搜索功能待开发'),
          ),
          // 消息按钮
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () => _showTip('消息中心待开发'),
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
      // 底部导航（调大字体：原27→32）
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedLabelStyle: const TextStyle(fontSize: 32), // 再调大5号
        unselectedLabelStyle: const TextStyle(fontSize: 32), // 再调大5号
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

  // 通用提示弹窗（调大字体：原27→32）
  void _showTip(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)), // 再调大5号
    ));
  }
}

// 1. 作品展示广场
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
                  fontSize: 44, fontWeight: FontWeight.bold)), // 原39→44
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
                          style: TextStyle(fontSize: 32))), // 原27→32
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
                        TextStyle(color: Colors.pink, fontSize: 32)), // 原27→32
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

  // 作品条目（调大字体）
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
                    fontSize: 36, fontWeight: FontWeight.bold)), // 原31→36
            const SizedBox(height: 8),
            Row(
              children: [
                Text('作者：$author',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 34)), // 原29→34
                const SizedBox(width: 16),
                Text('分类：$type',
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 34)), // 原29→34
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.pink),
                    onPressed: () {}),
                Text('$like', style: const TextStyle(fontSize: 32)), // 原27→32
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

  // 提示弹窗（调大字体：原27→32）
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)), // 再调大5号
    ));
  }
}

// 2. 创作工坊
class CreateWorkshopPage extends StatelessWidget {
  const CreateWorkshopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('创作工坊',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)), // 原39→44
          const SizedBox(height: 20),
          // 创作工具网格
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCard(Icons.brush, '绘画创作', '笔刷+图层+特效'),
                _buildCard(Icons.animation, '动画制作', '骨骼动画+关键帧'),
                _buildCard(Icons.book, '小说写作', '灵感素材+剧情大纲'),
                _buildCard(Icons.music_note, '音乐创作', '虚拟乐器+音频编辑'),
                _buildCard(Icons.auto_awesome, 'AI辅助创作', '生成角色/故事/配乐',
                    Colors.pink[100]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 创作工具卡片（调大字体）
  Widget _buildCard(IconData icon, String title, String desc, [Color? color]) {
    return Card(
      elevation: 2,
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 66, color: Colors.pink), // 原61→66（同步放大）
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 38, fontWeight: FontWeight.bold)), // 原33→38
            const SizedBox(height: 8),
            Text(desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 32)), // 原27→32
          ],
        ),
      ),
    );
  }
}

// 3. 交易市场
class TradeMarketPage extends StatelessWidget {
  const TradeMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('交易市场',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)), // 原39→44
          const SizedBox(height: 20),
          // 分类标签
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['版权售卖', '二手商品', '实体周边', '数字周边', '漫展门票'].map((tag) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      Text(tag, style: const TextStyle(fontSize: 32)), // 原27→32
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // 商品列表
          Expanded(
            child: ListView(
              children: [
                _buildGoodsItem('《原神》同人漫画版权', '¥2999', '版权售卖'),
                _buildGoodsItem('雷电将军cos服（L码）', '¥399', '二手商品'),
                _buildGoodsItem('祢豆子手办', '¥199', '实体周边'),
                _buildGoodsItem('上海漫展VIP门票', '¥299', '漫展门票'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 商品条目（调大字体）
  Widget _buildGoodsItem(String title, String price, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag,
            color: Colors.pink, size: 46), // 原41→46（同步放大）
        title: Text(title, style: const TextStyle(fontSize: 36)), // 原31→36
        subtitle:
            Text('分类：$type', style: const TextStyle(fontSize: 32)), // 原27→32
        trailing: Text(price,
            style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 34)), // 原29→34
        onTap: () {},
      ),
    );
  }
}

// 4. 次元社交圈
class SocialCirclePage extends StatelessWidget {
  const SocialCirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('次元社交圈',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold)), // 原39→44
          const SizedBox(height: 20),
          // 功能按钮
          Row(
            children: [
              _buildSocialBtn(Icons.group_add, '创建小组', context),
              const SizedBox(width: 16),
              _buildSocialBtn(Icons.message, '私信', context),
              const SizedBox(width: 16),
              _buildSocialBtn(Icons.event, '漫展活动', context),
            ],
          ),
          const SizedBox(height: 20),
          // 兴趣小组
          const Text('热门兴趣小组',
              style: TextStyle(
                  fontSize: 38, fontWeight: FontWeight.bold)), // 原33→38
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildGroupItem('原神交流群', '2345人', '璃月/蒙德剧情讨论'),
                _buildGroupItem('鬼灭之刃粉丝团', '1890人', '同人创作/角色分析'),
                _buildGroupItem('日语动漫学习社', '987人', '动漫台词/日语交流'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 社交功能按钮（调大字体）
  Widget _buildSocialBtn(IconData icon, String text, BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[100],
          foregroundColor: Colors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _showTip(context, '$text待开发'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 38), // 原33→38（同步放大）
            const SizedBox(height: 4),
            Text(text, style: const TextStyle(fontSize: 32)) // 原27→32
          ],
        ),
      ),
    );
  }

  // 兴趣小组条目（调大字体）
  Widget _buildGroupItem(String name, String count, String desc) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 93, 37, 57),
          child: Icon(Icons.people, color: Colors.pink, size: 42)), // 原37→42
      title: Text(name, style: const TextStyle(fontSize: 36)), // 原31→36
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 32)), // 原27→32
          Text(desc,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 32)), // 原27→32
        ],
      ),
      trailing: TextButton(
          onPressed: () {},
          child: const Text('加入',
              style: TextStyle(color: Colors.pink, fontSize: 32))), // 原27→32
    );
  }

  // 提示弹窗（调大字体）
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)), // 原27→32
    ));
  }
}

// 5. 语言学习空间
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
                  fontSize: 44, fontWeight: FontWeight.bold)), // 原39→44
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

  // 语言课程卡片（调大字体）
  Widget _buildLangCard(String lang, String material) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language, size: 54, color: Colors.pink), // 原49→54
            const SizedBox(height: 8),
            Text(lang,
                style: const TextStyle(
                    fontSize: 38, fontWeight: FontWeight.bold)), // 原33→38
            const SizedBox(height: 4),
            Text(material,
                style:
                    const TextStyle(color: Colors.grey, fontSize: 30), // 原25→30
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // 学习功能按钮（调大字体）
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
            Icon(icon, color: Colors.pink, size: 34), // 原29→34
            const SizedBox(width: 4),
            Text(text,
                style:
                    const TextStyle(color: Colors.pink, fontSize: 32)) // 原27→32
          ],
        ),
      ),
    );
  }

  // 提示弹窗（调大字体）
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)), // 原27→32
    ));
  }
}

// 6. 个人中心
class PersonalCenterPage extends StatelessWidget {
  const PersonalCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        titleTextStyle: const TextStyle(
          fontSize: 38, // 原33→38（再调大5号）
          fontWeight: FontWeight.bold,
          color: Colors.white, // 颜色不变
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings, size: 38), // 原33→38
              onPressed: () => _showTip(context, '设置待开发'))
        ],
      ),
      body: Padding(
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
                        child: Text('hi', style: TextStyle(fontSize: 38)),
                        radius: 40), // 原33→38
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('次元创作者',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)), // 原35→40
                          const SizedBox(height: 8),
                          Text('个性签名：用创作点亮次元世界 ✨',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 34)), // 原29→34
                          TextButton(
                              onPressed: () => _showTip(context, '编辑资料待开发'),
                              child: const Text('编辑资料',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 32))), // 原27→32
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 功能入口
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildFuncItem('我的作品', Icons.article, context),
                  _buildFuncItem('我的收藏', Icons.favorite, context),
                  _buildFuncItem('我的订单', Icons.shopping_cart, context),
                  _buildFuncItem('我的小组', Icons.group, context),
                  _buildFuncItem('学习记录', Icons.history, context),
                  _buildFuncItem('帮助中心', Icons.help, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 个人中心功能项（调大字体）
  Widget _buildFuncItem(String text, IconData icon, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _showTip(context, '$text待开发'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 54, color: Colors.pink), // 原49→54
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 34)) // 原29→34
          ],
        ),
      ),
    );
  }

  // 提示弹窗（调大字体）
  void _showTip(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 32)), // 原27→32
    ));
  }
}
