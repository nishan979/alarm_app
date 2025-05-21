import 'package:alarmapp/features/home/alarms/alarm_model.dart';
import 'package:alarmapp/features/home/alarms/alarm_service.dart';
import 'package:get/get.dart';
import 'package:alarmapp/helpers/notification_helper.dart';  // import your notification helper

class AlarmController extends GetxController {
  final RxList<Alarm> alarms = <Alarm>[].obs;
  final AlarmService _alarmService = AlarmService();

  @override
  void onInit() {
    loadAlarms();
    super.onInit();
  }

  Future<void> loadAlarms() async {
    final storedAlarms = await _alarmService.getAlarms();
    alarms.assignAll(storedAlarms);
  }

  Future<void> addAlarm(Alarm newAlarm) async {
    alarms.add(newAlarm);
    await _saveAlarms();

    if (newAlarm.isActive) {
      await NotificationHelper.scheduleNotification(
        id: newAlarm.id, // Make sure your Alarm model has a unique int id
        title: 'Alarm',
        body: 'It\'s time for your alarm!',
        scheduledDateTime: newAlarm.dateTime,
      );
    }
  }

  Future<void> toggleAlarm(int index) async {
    final alarm = alarms[index];
    alarm.isActive = !alarm.isActive;
    await _saveAlarms();

    if (alarm.isActive) {
      // Schedule notification when enabled
      await NotificationHelper.scheduleNotification(
        id: alarm.id,
        title: 'Alarm',
        body: 'It\'s time for your alarm!',
        scheduledDateTime: alarm.dateTime,
      );
    } else {
      // Cancel notification when disabled
      await NotificationHelper.cancelNotification(alarm.id);
    }
  }

  Future<void> deleteAlarm(int index) async {
    final alarm = alarms[index];
    alarms.removeAt(index);
    await _saveAlarms();

    // Cancel notification when deleted
    await NotificationHelper.cancelNotification(alarm.id);
  }

  Future<void> _saveAlarms() async {
    await _alarmService.saveAlarms(alarms);
    alarms.refresh();
  }
}
