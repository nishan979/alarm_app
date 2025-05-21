import 'dart:convert'; // Add this!

import 'package:alarmapp/features/home/alarms/alarm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmService {
  static const _key = 'alarms';

  Future<List<Alarm>> getAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson = prefs.getStringList(_key) ?? [];

    return alarmsJson
        .map((jsonString) => Alarm.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<void> saveAlarms(List<Alarm> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson =
        alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList(_key, alarmsJson);
  }
}
