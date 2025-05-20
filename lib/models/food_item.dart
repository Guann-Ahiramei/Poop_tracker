import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final int price; // energy
  final String iconPath;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.iconPath,
  });

  // 用于存储到 Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'iconPath': iconPath,
    };
  }

  // 从 Firebase 读取
  factory FoodItem.fromMap(String id, Map<String, dynamic> map) {
    return FoodItem(
      id: id,
      name: map['name'],
      price: map['price'],
      iconPath: map['iconPath'],
    );
  }
}
