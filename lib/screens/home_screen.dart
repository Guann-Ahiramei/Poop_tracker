import 'package:flutter/material.dart';
import 'package:tummytales/screens/stats_screen.dart';
import '../models/poop_entry.dart';
import '../services/poop_storage.dart';
import '../widgets/poop_icon_picker.dart';

class HomeScreen extends StatefulWidget {
  final List<PoopEntry> entries;
  final Function(PoopEntry) onNewEntry;

  const HomeScreen({
    super.key,
    required this.entries,
    required this.onNewEntry,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PoopStorage _storage = PoopStorage();
  List<PoopEntry> get _entries => widget.entries;
  String _selectedIcon = 'assets/images/solid.png';
  String _selectedLabel = 'Solid';

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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.brown),
        //   onPressed: () {
        //     Navigator.pop(context); // 如果是嵌套在 Navigator 中
        //   },
        // ),
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
            child: Text("CHOOSE POOP TYPE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
          ),
          PoopIconPicker(
            onSelected: (icon, label) {
              setState(() {
                _selectedIcon = icon;
                _selectedLabel = label;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9FC19D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Add", style: TextStyle(fontSize: 18)),
              onPressed: () {
                final entry = PoopEntry(
                  iconPath: _selectedIcon,
                  label: _selectedLabel,
                  timestamp: DateTime.now(),
                );
                widget.onNewEntry(entry); // ✅ 通知 MainScreen 添加记录
              },
            ),
          ),
        ],
      ),
    );
  }
}
