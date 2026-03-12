import 'package:ciyuanxinghe_mod/api/api_service.dart';

class CourseService {
  // 获取所有课程
  static Future<List<dynamic>> getAllCourses() async {
    return await ApiService.get('/courses');
  }

  // 根据ID获取课程
  static Future<dynamic> getCourseById(int id) async {
    return await ApiService.get('/courses/$id');
  }

  // 根据语言获取课程
  static Future<List<dynamic>> getCoursesByLanguage(String language) async {
    return await ApiService.get('/courses/language/$language');
  }

  // 根据用户ID获取课程
  static Future<List<dynamic>> getCoursesByUserId(int userId) async {
    return await ApiService.get('/courses/user/$userId');
  }

  // 搜索课程
  static Future<List<dynamic>> searchCourses(String keyword) async {
    return await ApiService.get('/courses/search/$keyword');
  }

  // 创建课程
  static Future<dynamic> createCourse(Map<String, dynamic> course) async {
    return await ApiService.post('/courses', course);
  }

  // 更新课程
  static Future<dynamic> updateCourse(int id, Map<String, dynamic> course) async {
    return await ApiService.put('/courses/$id', course);
  }

  // 删除课程
  static Future<void> deleteCourse(int id) async {
    await ApiService.delete('/courses/$id');
  }

  // 报名课程
  static Future<dynamic> enrollCourse(int id) async {
    return await ApiService.post('/courses/$id/enroll', {});
  }
}
