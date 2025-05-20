import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tummytales/screens/backpack_screen.dart';
import '../providers/kitchen_provider.dart';
import '../models/food_item.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kitchen = Provider.of<KitchenProvider>(context);
    final items = kitchen.availableItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.shopping_bag, color: Colors.brown),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BackpackScreen()),
            );
          }
        ),
        centerTitle: true,
        title: const Text('Kitchen', style: TextStyle(color: Colors.brown)),
        actions: [
          Row(
            children: [
              const Icon(Icons.bolt, color: Colors.orange),
              const SizedBox(width: 4),
              Text('${kitchen.energy}', style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // 广告栏
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.local_dining, size: 30),
                SizedBox(width: 8),
                Expanded(child: Text("🍽️ Tap on a food to buy and boost your energy!")),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 食物网格列表
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: items.map((item) {
                final canBuy = kitchen.canBuy(item);
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Buy ${item.name}?'),
                        content: Text('This will cost ${item.price} energy.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: canBuy
                                ? () {
                              kitchen.buy(item);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('You bought ${item.name}!')),
                              );
                            }
                                : null,
                            child: const Text('Buy'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(item.iconPath, height: 50),
                        const SizedBox(height: 8),
                        Text(item.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text('${item.price}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
