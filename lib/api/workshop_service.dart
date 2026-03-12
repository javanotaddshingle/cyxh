import 'package:ciyuanxinghe_mod/api/api_service.dart';

class WorkshopService {
  // 获取所有工坊
  static Future<List<dynamic>> getAllWorkshops() async {
    return await ApiService.get('/workshops');
  }

  // 根据ID获取工坊
  static Future<dynamic> getWorkshopById(int id) async {
    return await ApiService.get('/workshops/$id');
  }

  // 根据分类获取工坊
  static Future<List<dynamic>> getWorkshopsByCategory(String category) async {
    return await ApiService.get('/workshops/category/$category');
  }

  // 根据用户ID获取工坊
  static Future<List<dynamic>> getWorkshopsByUserId(int userId) async {
    return await ApiService.get('/workshops/user/$userId');
  }

  // 搜索工坊
  static Future<List<dynamic>> searchWorkshops(String keyword) async {
    return await ApiService.get('/workshops/search/$keyword');
  }

  // 创建工坊
  static Future<dynamic> createWorkshop(Map<String, dynamic> workshop) async {
    return await ApiService.post('/workshops', workshop);
  }

  // 更新工坊
  static Future<dynamic> updateWorkshop(int id, Map<String, dynamic> workshop) async {
    return await ApiService.put('/workshops/$id', workshop);
  }

  // 删除工坊
  static Future<void> deleteWorkshop(int id) async {
    await ApiService.delete('/workshops/$id');
  }

  // 加入工坊
  static Future<dynamic> joinWorkshop(int id) async {
    return await ApiService.post('/workshops/$id/join', {});
  }
}
