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
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(options.length, (index){
        final isSelected = index == _selectedIndex;
        final icon = options[index]['icon']!;
        final label = options[index]['label']!;
        return GestureDetector(
          onTap: (){
            setState(() => _selectedIndex = index);
            widget.onSelected(icon, label);
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: isSelected ? Border.all(color: Colors.brown, width: 2) : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(icon, height: 60),
              ),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        );
      }),
    );
  }
}
