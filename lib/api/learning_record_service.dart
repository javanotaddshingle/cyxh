import 'package:ciyuanxinghe_mod/api/api_service.dart';

class LearningRecordService {
  // 创建或更新学习记录
  static Future<dynamic> createOrUpdateRecord(Map<String, dynamic> record) async {
    return await ApiService.post('/learning-records', record);
  }

  // 获取用户学习记录
  static Future<List<dynamic>> getUserLearningRecords(int userId) async {
    return await ApiService.get('/learning-records/user/$userId');
  }

  // 获取用户特定课程的学习记录
  static Future<dynamic> getUserCourseRecord(int userId, int courseId) async {
    return await ApiService.get('/learning-records/user/$userId/course/$courseId');
  }

  // 更新学习进度
  static Future<dynamic> updateProgress(int id, int progress) async {
    return await ApiService.post('/learning-records/$id/progress', {'progress': progress});
  }
}
