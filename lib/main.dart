import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home/main_home_page.dart';

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
        // 新增：统一调大AppBar标题字体
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 212, 75, 178),
          ),
        ),
      ),
      home: const MainHomePage(),
      debugShowCheckedModeBanner: false, // 隐藏调试水印
    );
  }
}

