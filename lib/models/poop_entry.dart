class PoopEntry {
  final String iconPath;        // 存储图标的路径（比如便便的形状）
  final DateTime timestamp;     // 存储时间戳（记录这次便便的时间）

  // 构造函数，要求两个字段必须有值
  PoopEntry({required this.iconPath, required this.timestamp});

  // 把对象转成 JSON（用于保存）
  Map<String, dynamic> toJson() => {
    'iconPath': iconPath,
    'timestamp': timestamp.toIso8601String(), // 日期转字符串
  };

  factory PoopEntry.fromJson(Map<String, dynamic> json) => PoopEntry(
    iconPath: json['iconPath'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
