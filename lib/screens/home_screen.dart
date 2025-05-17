import 'package:flutter/material.dart';
import '../models/poop_entry.dart';
import '../services/poop_storage.dart';
import '../utils/date_utils.dart';
import 'add_poop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PoopStorage _storage = PoopStorage();
  List<PoopEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    final loaded = await _storage.load();
    setState(() => _entries = loaded);
  }

  void _addEntry(PoopEntry entry) async {
    setState(() => _entries.add(entry));
    await _storage.save(_entries);
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<PoopEntry>>{};
    for (var e in _entries) {
      final date = formatDate(e.timestamp);
      grouped.putIfAbsent(date, () => []).add(e);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Poop Tracker')),
      body: ListView(
        children: grouped.entries.map((entry) {
          return ExpansionTile(
            title: Text(entry.key),
            children: entry.value.map((e) {
              return ListTile(
                leading: Image.asset(e.iconPath, height: 30),
                title: Text('${e.timestamp.hour}:${e.timestamp.minute.toString().padLeft(2, '0')}'),
              );
            }).toList(),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPoopScreen()),
          );
          if (result is PoopEntry) _addEntry(result);
        },
      ),
    );
  }
}
