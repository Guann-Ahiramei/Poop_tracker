import 'package:flutter/material.dart';

class PoopIconPicker extends StatefulWidget {
  final Function(String) onIconSelected;

  const PoopIconPicker({super.key, required this.onIconSelected});

  @override
  State<PoopIconPicker> createState() => _PoopIconPickerState();
}

class _PoopIconPickerState extends State<PoopIconPicker> {
  final List<String> _iconPaths = [
    'assets/images/poop1.png',
    'assets/images/poop2.png',
    'assets/images/poop3.png',
    'assets/images/poop4.png',
    'assets/images/poop5.png',
    'assets/images/poop6.png',
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.onIconSelected(_iconPaths[_selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_iconPaths.length, (index) {
            final isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
                widget.onIconSelected(_iconPaths[index]);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(color: Colors.brown, width: 3)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  _iconPaths[index],
                  height: 60,
                  width: 60,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
