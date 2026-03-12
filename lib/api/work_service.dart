import 'package:ciyuanxinghe_mod/api/api_service.dart';

class WorkService {
  // 获取所有作品
  static Future<List<dynamic>> getAllWorks() async {
    return await ApiService.get('/works');
  }

  // 根据ID获取作品
  static Future<dynamic> getWorkById(int id) async {
    return await ApiService.get('/works/$id');
  }

  // 根据分类获取作品
  static Future<List<dynamic>> getWorksByCategory(String category) async {
    return await ApiService.get('/works/category/$category');
  }

  // 根据用户ID获取作品
  static Future<List<dynamic>> getWorksByUserId(int userId) async {
    return await ApiService.get('/works/user/$userId');
  }

  // 搜索作品
  static Future<List<dynamic>> searchWorks(String keyword) async {
    return await ApiService.get('/works/search/$keyword');
  }

  // 创建作品
  static Future<dynamic> createWork(Map<String, dynamic> work) async {
    return await ApiService.post('/works', work);
  }

  // 更新作品
  static Future<dynamic> updateWork(int id, Map<String, dynamic> work) async {
    return await ApiService.put('/works/$id', work);
  }

  // 删除作品
  static Future<void> deleteWork(int id) async {
    await ApiService.delete('/works/$id');
  }

  // 点赞作品
  static Future<dynamic> likeWork(int id, int userId) async {
    return await ApiService.post('/works/$id/like?userId=$userId', {});
  }

  // 收藏作品
  static Future<dynamic> favoriteWork(int id, int userId) async {
    return await ApiService.post('/works/$id/favorite?userId=$userId', {});
  }

  // 检查是否已收藏
  static Future<dynamic> isWorkFavorited(int id, int userId) async {
    return await ApiService.get('/works/$id/isFavorited?userId=$userId');
  }

  // 获取用户收藏的作品
  static Future<List<dynamic>> getUserFavoriteWorks(int userId) async {
    return await ApiService.get('/works/user/$userId/favorites');
  }

  // 获取排行榜
  static Future<List<dynamic>> getWorkRanking(String type) async {
    return await ApiService.get('/works/ranking?type=$type');
  }
}
