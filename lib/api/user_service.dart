import 'package:ciyuanxinghe_mod/api/api_service.dart';

class UserService {
  // 用户注册
  static Future<dynamic> register(Map<String, dynamic> user) async {
    return await ApiService.post('/users/register', user);
  }

  // 用户登录
  static Future<dynamic> login(String username, String password) async {
    return await ApiService.get('/users/login?username=$username&password=$password');
  }

  // 根据ID获取用户
  static Future<dynamic> getUserById(int id) async {
    return await ApiService.get('/users/$id');
  }

  // 更新用户信息
  static Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    return await ApiService.put('/users/$id', user);
  }

  // 删除用户
  static Future<void> deleteUser(int id) async {
    await ApiService.delete('/users/$id');
  }
}
