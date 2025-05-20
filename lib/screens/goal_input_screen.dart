import 'package:flutter/material.dart';

class GoalInputScreen extends StatefulWidget {
  final String? initialTitle;
  final DateTime? startTime;
  final DateTime? endTime;
  final IconData? icon;
  final int? energy;

  const GoalInputScreen({super.key, this.initialTitle, this.startTime, this.endTime, this.icon,this.energy});

  @override
  State<GoalInputScreen> createState() => _GoalInputScreenState();
}

class _GoalInputScreenState extends State<GoalInputScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _warning;
  late DateTime _startTime;
  late DateTime _endTime;
  late int _energy;


  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialTitle ?? '';
    _startTime = widget.startTime ?? DateTime.now();
    _endTime = widget.endTime ?? DateTime.now().add(const Duration(hours: 1));
    _energy = widget.energy ?? 0;
  }

  Future<void> _pickDateTime({required bool isStart}) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _startTime : _endTime,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _startTime : _endTime),
    );
    if (time == null) return;

    final selected = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startTime = selected;
      } else {
        _endTime = selected;
      }
    });
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty || text.length > 20) {
      setState(() => _warning = 'Please enter 1–20 characters.');
    } else {
      Navigator.pop(context, {
        'title': text,
        'startTime': _startTime,
        'endTime': _endTime,
        'icon': widget.icon,
        'energy': _energy,
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('New Goal', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: "Enter your goal...",
                border: UnderlineInputBorder(),
              ),
            ),
            if (_warning != null)
              Text(_warning!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Start: ", style: TextStyle(fontSize: 14)),
                TextButton(
                  onPressed: () => _pickDateTime(isStart: true),
                  child: Text(_startTime.toLocal().toString().substring(0, 16)),
                ),
              ],
            ),
            Row(
              children: [
                const Text("End: ", style: TextStyle(fontSize: 14)),
                TextButton(
                  onPressed: () => _pickDateTime(isStart: false),
                  child: Text(_endTime.toLocal().toString().substring(0, 16)),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("⚡ $_energy", style: TextStyle(color: Colors.orange)),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Done"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
