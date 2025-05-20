import 'package:flutter/material.dart';
import 'goal_ideas_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  final List<Map<String, dynamic>> _features = const [
    {'icon': 'assets/images/goals_of_day.png', 'label': 'Goal Ideas', 'color': Color(0xFFFFD3B5)},
    {'icon': 'assets/images/reflection.png', 'label': 'Reflections', 'color': Color(0xFFE8D9F5)},
    {'icon': 'assets/images/breathe.png', 'label': 'Breathe', 'color': Color(0xFFDAF0D2)},
    {'icon': 'assets/images/connect_with_love.png', 'label': 'Memory', 'color': Color(0xFFF9D8D6)},
    {'icon': 'assets/images/movement.png', 'label': 'Movements', 'color': Color(0xFFCCE5B5)},
    {'icon': 'assets/images/shelf.png', 'label': 'Shelf', 'color': Color(0xFFFFE7B3)},
    {'icon': 'assets/images/first_aid.png', 'label': 'First Aid', 'color': Color(0xFFFFD4A4)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Explore', style: TextStyle(color: Colors.brown)),
      ),
      body: Column(
        children: [
          // const SizedBox(height: 40),
          // Image.asset('assets/images/plane_flying.png', height: 120),
          // const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: _features.map((feature) {
                return GestureDetector(
                  onTap: () {
                    if (feature['label'] == 'Goal Ideas') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GoalIdeasScreen()),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: feature['color'],
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(feature['icon'], height: 48),
                        const SizedBox(height: 12),
                        Text(
                          feature['label'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
