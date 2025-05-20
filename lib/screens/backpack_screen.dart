import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kitchen_provider.dart';
import '../models/food_item.dart';

class BackpackScreen extends StatelessWidget {
  const BackpackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purchased = Provider.of<KitchenProvider>(context).purchasedItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        centerTitle: true,
        title: const Text('My Food Backpack 🍱', style: TextStyle(color: Colors.brown)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: purchased.isEmpty
          ? const Center(
        child: Text(
          'You haven’t bought any food yet!',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: purchased.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = purchased[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: Image.asset(item.iconPath, width: 40),
              title: Text(item.name),
              subtitle: Text('You already own this.'),
              trailing: ElevatedButton(
                onPressed: () {
                  // 你可以实现“使用”或“移除”逻辑
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Used ${item.name} 🎉')),
                  );
                },
                child: const Text('Use'),
              ),
            ),
          );
        },
      ),
    );
  }
}
