import 'package:flutter/material.dart';
import '../models/poop_entry.dart';
import '../widgets/poop_icon_picker.dart';

class AddPoopScreen extends StatefulWidget {
  const AddPoopScreen({super.key});

  @override
  State<AddPoopScreen> createState() => _AddPoopScreenState();
}

class _AddPoopScreenState extends State<AddPoopScreen> {
  String _selectedIcon = 'assets/images/poop1.png';

  void _onIconSelected(String path) {
    setState(() => _selectedIcon = path);
  }

  void _submit() {
    final entry = PoopEntry(
      iconPath: _selectedIcon,
      timestamp: DateTime.now(),
    );
    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Poop Record')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PoopIconPicker(onIconSelected: (iconPath) {
            _selectedIcon = iconPath;
          },),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Add Record'),
          ),
        ],
      ),
    );
  }
}
