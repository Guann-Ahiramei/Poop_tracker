import 'package:flutter/material.dart';
import 'package:poop_tracker/screens/stats_screen.dart';
import '../models/poop_entry.dart';
import '../services/poop_storage.dart';
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

  Widget _buildPoopRecord(PoopEntry entry) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Image.asset(entry.iconPath, height: 50),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${_formatTime(entry.timestamp)}\n",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: entry.label,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.brown,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
        trailing: Text(_formatDate(entry.timestamp)),
    );
  }

  String _formatDate(DateTime dt) {
    return "${_monthAbbr(dt.month)} ${dt.day}";
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour % 12 == 0 ? 12 : dt.hour % 12}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour < 12 ? 'AM' : 'PM'}";
  }

  String _monthAbbr(int m) => ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][m - 1];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        centerTitle: true,
        title: const Text('POOp', style: TextStyle(color: Colors.brown)),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.brown),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StatsScreen(entries: _entries)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            children: _entries.map(_buildPoopRecord).toList(),
            )
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("NEW ENTRY", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9FC19D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text("Add", style: TextStyle(fontSize: 18)),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPoopScreen()),
                );
              if (result is PoopEntry) _addEntry(result);
             },
            ),
          ),
        ],
      ),
    );
  }
}
