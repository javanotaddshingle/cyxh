import 'package:flutter/material.dart';

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
                  fontSize: 44, fontWeight: FontWeight.bold)),
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
                      Text(tag, style: const TextStyle(fontSize: 32)),
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

  // 商品条目
  Widget _buildGoodsItem(String title, String price, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag,
            color: Colors.pink, size: 46),
        title: Text(title, style: const TextStyle(fontSize: 36)),
        subtitle:
            Text('分类：$type', style: const TextStyle(fontSize: 32)),
        trailing: Text(price,
            style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 34)),
        onTap: () {},
      ),
    );
  }
}
