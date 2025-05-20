import 'package:flutter/material.dart';
import '../models/food_item.dart';

class KitchenProvider with ChangeNotifier {
  int _energy = 317;

  final List<FoodItem> _availableItems = [
    FoodItem(
      id: '1',
      name: 'Pudding',
      price: 120,
      iconPath: 'assets/images/pudding.png',
    ),
    FoodItem(
      id: '2',
      name: 'Char Siu Rice',
      price: 200,
      iconPath: 'assets/images/char_siu.png',
    ),
    FoodItem(
      id: '3',
      name: 'Cream Puff',
      price: 150,
      iconPath: 'assets/images/cream_puff.png',
    ),
  ];

  final List<FoodItem> _purchasedItems = [];

  int get energy => _energy;
  List<FoodItem> get availableItems => _availableItems;
  List<FoodItem> get purchasedItems => _purchasedItems;

  bool canBuy(FoodItem item) => _energy >= item.price;

  void buy(FoodItem item) {
    if (canBuy(item)) {
      _energy -= item.price;
      _purchasedItems.add(item);
      notifyListeners();
    }
  }

  void earnEnergy(int amount) {
    _energy += amount;
    notifyListeners();
  }

}
