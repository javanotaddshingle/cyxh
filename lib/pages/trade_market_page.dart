import 'package:flutter/material.dart';
import 'package:ciyuanxinghe_mod/api/trade_service.dart';

class TradeMarketPage extends StatefulWidget {
  const TradeMarketPage({super.key});

  @override
  State<TradeMarketPage> createState() => _TradeMarketPageState();
}

class _TradeMarketPageState extends State<TradeMarketPage> {
  List<dynamic> _trades = [];
  bool _isLoading = true;
  String _selectedCategory = '全部';

  @override
  void initState() {
    super.initState();
    _loadTrades();
  }

  Future<void> _loadTrades() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<dynamic> trades;
      if (_selectedCategory == '全部') {
        trades = await TradeService.getAllTrades();
      } else {
        trades = await TradeService.getTradesByCategory(_selectedCategory);
      }
      // 添加默认数据
      if (trades.isEmpty) {
        trades = [
          {
            'id': 1,
            'title': '初音手办',
            'category': '实体周边',
            'price': 299.0,
            'userId': 1
          },
          {
            'id': 2,
            'title': '日轮刀模型',
            'category': '实体周边',
            'price': 199.0,
            'userId': 2
          },
          {
            'id': 3,
            'title': '派蒙抱枕',
            'category': '实体周边',
            'price': 89.0,
            'userId': 1
          },
          {
            'id': 4,
            'title': '动漫海报',
            'category': '实体周边',
            'price': 29.0,
            'userId': 3
          }
        ];
      }
      setState(() {
        _trades = trades;
        _isLoading = false;
      });
    } catch (e) {
      // 即使出错也显示默认数据
      setState(() {
        _trades = [
          {
            'id': 1,
            'title': '初音手办',
            'category': '实体周边',
            'price': 299.0,
            'userId': 1
          },
          {
            'id': 2,
            'title': '日轮刀模型',
            'category': '实体周边',
            'price': 199.0,
            'userId': 2
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
          const Text('交易市场',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // 分类标签
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: ['全部', '版权售卖', '二手商品', '实体周边', '数字周边', '漫展门票'].map((tag) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = tag;
                      });
                      _loadTrades();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _selectedCategory == tag ? Colors.pink[100] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          Text(tag, style: const TextStyle(fontSize: 14)),
                    ),
                  );
                }).toList(),
              ),
          ),
          const SizedBox(height: 20),
          // 商品列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _trades.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('暂无交易数据',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView(
                        children: _trades.map((trade) => _buildGoodsItem(trade)).toList(),
                      ),
          ),
        ],
      ),
    );
  }

  // 商品条目
  Widget _buildGoodsItem(dynamic trade) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag,
            color: Colors.pink, size: 30),
        title: Text(trade['title'], style: const TextStyle(fontSize: 16)),
        subtitle:
            Text('分类：${trade['category']}', style: const TextStyle(fontSize: 14)),
        trailing: Text('¥${trade['price']}',
            style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        onTap: () {},
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
