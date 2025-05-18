import 'package:flutter/material.dart';

class PoopIconPicker extends StatefulWidget {
  final Function(String, String) onSelected;

  const PoopIconPicker({super.key, required this.onSelected});

  @override
  State<PoopIconPicker> createState() => _PoopIconPickerState();
}

class _PoopIconPickerState extends State<PoopIconPicker> {
  final List<Map<String, String>> options = [
    {"icon": "assets/images/watery.png", "label": "Watery"},
    {"icon": "assets/images/soft.png", "label": "Soft"},
    {"icon": "assets/images/lumpy.png", "label": "Lumpy"},
    {"icon": "assets/images/gntle.png", "label": "Gntle"},
    {"icon": "assets/images/solid.png", "label": "Solid"},
    {"icon": "assets/images/splash.png", "label": "Splash"},
    {"icon": "assets/images/pebble.png", "label": "Pebble"},
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSelected(options[_selectedIndex]['icon']!, options[_selectedIndex]['label']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // 高度固定，适配横向滑动
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          final selected = index == _selectedIndex;
          final iconPath = options[index]['icon']!;
          final label = options[index]['label']!;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSelected(iconPath, label);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected ? Colors.brown : Colors.transparent,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(iconPath, height: 60, width: 60),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? Colors.brown : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
