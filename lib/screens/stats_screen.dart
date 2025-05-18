import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/poop_entry.dart';

class StatsScreen extends StatelessWidget {
  final List<PoopEntry> entries;

  const StatsScreen({super.key, required this.entries});

  // 统计每天便便次数
  Map<String, int> getPoopCountPerDay() {
    final now = DateTime.now();
    final formatter = DateFormat('MM-dd');
    final Map<String, int> dailyCounts = {};

    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dateKey = formatter.format(day);
      dailyCounts[dateKey] = 0;
    }

    for (final entry in entries) {
      final dateKey = formatter.format(entry.timestamp);
      if (dailyCounts.containsKey(dateKey)) {
        dailyCounts[dateKey] = dailyCounts[dateKey]! + 1;
      }
    }

    return dailyCounts;
  }

  // 统计每种便便类型的次数
  Map<String, int> getPoopCountPerType() {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: 7));
    final Map<String, int> typeCounts = {};

    for (final entry in entries) {
      if (entry.timestamp.isAfter(cutoff)) {
        typeCounts[entry.label] = (typeCounts[entry.label] ?? 0) + 1;
      }
    }

    return typeCounts;
  }

  @override
  Widget build(BuildContext context) {
    final dailyData = getPoopCountPerDay();
    final typeData = getPoopCountPerType();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poop Stats', style: TextStyle(color: Colors.brown)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFEFD6),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      backgroundColor: const Color(0xFFFDF4E8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '📅 Poop Counts by Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: dailyData.entries.toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    String label = entry.value.key;
                    int value = entry.value.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value.toDouble(),
                          width: 16,
                          color: Colors.brown,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= 0 && index < dailyData.length) {
                            return Text(
                              dailyData.keys.elementAt(index),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.brown,
                              ),
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Text(
                          "${value.toInt()}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '💩 Categories Count by Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: typeData.entries.toList().asMap().entries.map((entry) {
                    int index = entry.key;
                    String label = entry.value.key;
                    int value = entry.value.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value.toDouble(),
                          width: 16,
                          color: Colors.brown,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= 0 && index < typeData.length) {
                            return Text(
                              typeData.keys.elementAt(index),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.brown,
                              ),
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Text(
                          "${value.toInt()}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
