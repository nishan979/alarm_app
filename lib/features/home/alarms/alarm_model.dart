class Alarm {
  final int id;            // unique id for notification
  final DateTime dateTime;
  bool isActive;

  Alarm({
    required this.id,
    required this.dateTime,
    this.isActive = true,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'dateTime': dateTime.toIso8601String(),
    'isActive': isActive,
  };

  // Create from JSON
  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    id: json['id'],
    dateTime: DateTime.parse(json['dateTime']),
    isActive: json['isActive'],
  );
}
