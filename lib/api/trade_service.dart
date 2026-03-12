import 'package:ciyuanxinghe_mod/api/api_service.dart';

class TradeService {
  // 获取所有交易
  static Future<List<dynamic>> getAllTrades() async {
    return await ApiService.get('/trades');
  }

  // 根据ID获取交易
  static Future<dynamic> getTradeById(int id) async {
    return await ApiService.get('/trades/$id');
  }

  // 根据分类获取交易
  static Future<List<dynamic>> getTradesByCategory(String category) async {
    return await ApiService.get('/trades/category/$category');
  }

  // 根据用户ID获取交易
  static Future<List<dynamic>> getTradesByUserId(int userId) async {
    return await ApiService.get('/trades/user/$userId');
  }

  // 根据状态获取交易
  static Future<List<dynamic>> getTradesByStatus(String status) async {
    return await ApiService.get('/trades/status/$status');
  }

  // 搜索交易
  static Future<List<dynamic>> searchTrades(String keyword) async {
    return await ApiService.get('/trades/search/$keyword');
  }

  // 创建交易
  static Future<dynamic> createTrade(Map<String, dynamic> trade) async {
    return await ApiService.post('/trades', trade);
  }

  // 更新交易
  static Future<dynamic> updateTrade(int id, Map<String, dynamic> trade) async {
    return await ApiService.put('/trades/$id', trade);
  }

  // 删除交易
  static Future<void> deleteTrade(int id) async {
    await ApiService.delete('/trades/$id');
  }

  // 更新交易状态
  static Future<dynamic> updateTradeStatus(int id, String status) async {
    return await ApiService.put('/trades/$id/status?status=$status', {});
  }
}
