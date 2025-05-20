import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../providers/goal_provider.dart';
import '../providers/kitchen_provider.dart';
import 'goal_input_screen.dart';

class GoalListScreen extends StatefulWidget {
  const GoalListScreen({super.key});

  @override
  State<GoalListScreen> createState() => _GoalListScreenState();
}

class _GoalListScreenState extends State<GoalListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GoalProvider>(context, listen: false).loadGoals();
  }

  void _showMoodInput(BuildContext context, Goal goal, {bool isEditing = false}) {
    final controller = TextEditingController(text: isEditing ? goal.moodNote : '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEditing ? 'Edit Mood' : 'How do you feel?'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Write your mood...'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () async {
              final mood = controller.text.trim();
              await Provider.of<GoalProvider>(context, listen: false).completeGoal(
                goal.id,
                DateTime.now(),
                mood,
              );
              context.read<KitchenProvider>().earnEnergy(goal.energy);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You earned ⚡ ${goal.energy} energy!'),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goals = context.watch<GoalProvider>().goals;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        centerTitle: true,
        title: const Text('My Goals', style: TextStyle(color: Colors.brown)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<GoalProvider>().loadGoals(),
            color: Colors.brown,
          )
        ],
      ),
        body: ReorderableListView.builder(
          itemCount: goals.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          onReorder: (oldIndex, newIndex) async {
            if (newIndex > oldIndex) newIndex -= 1;

            final provider = context.read<GoalProvider>();
            provider.reorderGoals(oldIndex, newIndex);
            await provider.saveReorderedGoals(); // 可选：保存顺序到 Firebase
          },
          itemBuilder: (context, index) {
            final goal = goals[index];
            return Card(
              key: ValueKey(goal.id), // ✅ 必须设置 key
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE1F5C4),
                  child: Icon(goal.icon ?? Icons.flag, color: Colors.green[700]),
                ),
                title: Text(goal.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: goal.completed ? TextDecoration.lineThrough : null)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.completed
                        ? 'Completed at: ${goal.endTime?.toLocal().toString().substring(0, 16)}'
                        : 'Started at: ${goal.startTime.toLocal().toString().substring(0, 16)}'),
                    if (goal.energy != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('⚡ ${goal.energy}', style: const TextStyle(color: Colors.orange)),
                      ),

                    if (goal.moodNote != null && goal.moodNote!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Mood: ${goal.moodNote!}'),
                      )
                  ],
                ),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    if (!goal.completed)
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () => _showMoodInput(context, goal),
                      ),
                    if (goal.completed)
                      IconButton(
                        icon: const Icon(Icons.edit_note),
                        onPressed: () => _showMoodInput(context, goal, isEditing: true),
                      ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GoalInputScreen(
                              initialTitle: goal.title,
                              startTime: goal.startTime,
                              endTime: goal.endTime,
                              icon: goal.icon,
                            ),
                          ),
                        );
                        if (result is Map<String, dynamic>) {
                          await context.read<GoalProvider>().editGoal(goal.id, result['title']);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => context.read<GoalProvider>().deleteGoal(goal.id),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
