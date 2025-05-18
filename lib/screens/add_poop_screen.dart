import 'package:flutter/material.dart';
import '../models/poop_entry.dart';
import '../widgets/poop_icon_picker.dart';


class AddPoopScreen extends StatefulWidget {
  const AddPoopScreen({super.key});

  @override
  State<AddPoopScreen> createState() => _AddPoopScreenState();
}

class _AddPoopScreenState extends State<AddPoopScreen> {
  String _selectedIcon = 'assets/images/solid.png';
  String _selectedLabel = 'Solid';

  void _onSelected(String icon, String label) {
    print('Icon selected: $icon, label: $label');
    setState(() {
      _selectedIcon = icon;
      _selectedLabel = label;
    });
  }

  void _submit() {
    final entry = PoopEntry(
      iconPath: _selectedIcon,
      label: _selectedLabel,
      timestamp: DateTime.now(),
    );
    Navigator.pop(context, entry);
    print("Selected: $_selectedIcon, $_selectedLabel");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4E8),
      appBar: AppBar(
        title: const Text('New Entry'),
        backgroundColor: const Color(0xFFFFEFD6),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          PoopIconPicker(
              onSelected:  _onSelected,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9FC19D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Add", style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}
