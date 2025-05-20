import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/goal_provider.dart';
import '../models/goal.dart';
import 'goal_input_screen.dart';

class GoalIdeasScreen extends StatelessWidget {
  const GoalIdeasScreen({super.key});

  final List<Map<String, dynamic>> _goals = const [
    {
      'title': 'Goals of the day',
      'desc': 'Feel prepared by starting your day mindfully.',
      'icon': Icons.wb_sunny,
      'energy': 5, // ✅ 实际传递使用的 energy 数值
      'energyLabel': '5+ ⚡', // ✅ 可用于界面展示
    },
    {
      'title': 'New day, new you',
      'desc': 'Set goals for tomorrow to feel prepared.',
      'icon': Icons.brightness_5,
      'energy': 4,
      'energyLabel': '4+ ⚡',
    },
    {
      'title': 'Start a Journey',
      'desc': 'Build a routine with Bubble for long-term self-care.',
      'icon': Icons.explore,
      'energy': 10,
      'energyLabel': '10+ ⚡',
    },
    {
      'title': 'Sleep goals',
      'desc': 'Set the right intentions to sleep better tonight.',
      'icon': Icons.bedtime,
      'energy': 2,
      'energyLabel': '2+ ⚡',
    },
    {
      'title': 'Get active, be happy',
      'desc': 'Set a goal to energize yourself with movement!',
      'icon': Icons.directions_run,
      'energy': 2,
      'energyLabel': '2+ ⚡',
    },
    {
      'title': 'Connect with a loved one',
      'desc': 'Set time today for those who matter.',
      'icon': Icons.groups,
      'energy': 2,
      'energyLabel': '2+ ⚡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F2A4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD0F2A4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Goal Ideas', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: _goals.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE1F5C4),
                child: Icon(goal['icon'], color: Colors.green[700]),
              ),
              title: Text(goal['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(goal['desc']),
              trailing: Text(goal['energyLabel'], style: const TextStyle(fontSize: 12, color: Colors.orange)),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GoalInputScreen(
                      initialTitle: goal['title'],
                      startTime: DateTime.now(),
                      icon: goal['icon'],
                      energy: goal['energy'],
                    ),
                  ),
                );
                // ✅ 返回后，创建 Goal 对象并调用 provider
                if (result is Map<String, dynamic>) {
                  final newGoal = Goal(
                    id: '',
                    title: result['title'],
                    startTime: DateTime.now(),
                    completed: false,
                    energy: result['energy'] ?? 0,// ✅ 从 result 中读取 energy
                    icon: goal['icon'],
                  );
                  await Provider.of<GoalProvider>(context, listen: false).addGoal(newGoal);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
