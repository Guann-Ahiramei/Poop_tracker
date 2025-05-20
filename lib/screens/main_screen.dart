import 'package:flutter/material.dart';
import '../models/poop_entry.dart';
import 'explore_screen.dart';
import 'goal_list_screen.dart';
import 'home_screen.dart';
import 'kitchen_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<PoopEntry> _entries = []; // Poop 记录

  void _addEntry(PoopEntry entry) {
    setState(() {
      _entries.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(entries: _entries, onNewEntry: _addEntry),//接收一份当前的记录数据 entries,拿到一个添加记录的回调 onNewEntry(entry)
      const ExploreScreen(),
      GoalListScreen(),
      const KitchenScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFFFFEFD6),
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wc), label: 'Poop'),
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Kitchen'),
        ],
      ),
    );
  }
}
