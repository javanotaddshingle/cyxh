import 'package:ciyuanxinghe_mod/api/api_service.dart';

class PostService {
  // 获取所有帖子
  static Future<List<dynamic>> getAllPosts() async {
    return await ApiService.get('/posts');
  }

  // 根据ID获取帖子
  static Future<dynamic> getPostById(int id) async {
    return await ApiService.get('/posts/$id');
  }

  // 根据用户ID获取帖子
  static Future<List<dynamic>> getPostsByUserId(int userId) async {
    return await ApiService.get('/posts/user/$userId');
  }

  // 创建帖子
  static Future<dynamic> createPost(Map<String, dynamic> post) async {
    return await ApiService.post('/posts', post);
  }

  // 更新帖子
  static Future<dynamic> updatePost(int id, Map<String, dynamic> post) async {
    return await ApiService.put('/posts/$id', post);
  }

  // 删除帖子
  static Future<void> deletePost(int id) async {
    await ApiService.delete('/posts/$id');
  }

  // 点赞帖子
  static Future<dynamic> likePost(int id) async {
    return await ApiService.post('/posts/$id/like', {});
  }

  // 评论帖子
  static Future<dynamic> addComment(int id, int userId) async {
    return await ApiService.post('/posts/$id/comment?userId=$userId', {});
  }
}
