import 'package:alarmapp/features/home/alarms/alarm_controller.dart';
import 'package:alarmapp/features/home/alarms/alarm_model.dart';
import 'package:alarmapp/features/location/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<AlarmController>();
  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Location Section
            _buildLocationCard(),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text('Alarms', style: AppTextStyles.sectionHeading),
            ),
            const SizedBox(height: 16),

            // Alarms List
            Expanded(
              child: Obx(() => ListView.separated(
                    itemCount: controller.alarms.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                    itemBuilder: (context, index) => _buildAlarmItem(
                      alarm: controller.alarms[index],
                      index: index,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Obx(() {
      final address = locationController.currentAddress.value;

      return Card(
        color: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selected Location',
                style: AppTextStyles.locationTitle,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: AppColors.accentColor, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: AppTextStyles.locationAddress,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildAddAlarmButton(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAddAlarmButton() {
    int generateAlarmId() {
      return DateTime.now().millisecondsSinceEpoch;
    }

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        label: const Text('Add Alarm', style: AppTextStyles.buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardBackground,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () async {
          final controller = Get.find<AlarmController>();
          DateTime? selectedDate;
          TimeOfDay? selectedTime;

          await showDialog(
            context: Get.context!,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    title: const Text('Add New Alarm'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12), // Smaller padding
                            minimumSize:
                                const Size(0, 0), // Remove default min size
                            tapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // Shrink tap area
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Pick Date'
                                : '${selectedDate!.day.toString().padLeft(2, '0')} '
                                    '${selectedDate!.month.toString().padLeft(2, '0')} '
                                    '${selectedDate!.year}',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.white,
                              fontSize: 14, // Optional: reduce font size too
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedTime = pickedTime;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            selectedTime == null
                                ? 'Pick Time'
                                : selectedTime!.format(context),
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Cancel
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (selectedDate != null && selectedTime != null) {
                            final fullDateTime = DateTime(
                              selectedDate!.year,
                              selectedDate!.month,
                              selectedDate!.day,
                              selectedTime!.hour,
                              selectedTime!.minute,
                            );
                            final newAlarm = Alarm(
                              id: generateAlarmId(), // generate unique id
                              dateTime: fullDateTime,
                            );
                            controller.addAlarm(newAlarm);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAlarmItem({required Alarm alarm, required int index}) {
    return SizedBox(
      height: 80,
      child: Card(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('hh:mm a').format(alarm.dateTime),
                style: AppTextStyles.alarmTime,
              ),
              Spacer(),
              Text(
                DateFormat('EEE dd MMM yyyy').format(alarm.dateTime),
                style: AppTextStyles.alarmDate,
              ),
              SizedBox(
                width: 4,
              ),
              IconButton(
                color: Colors.red,
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(Icons.delete),
                onPressed: () => controller.deleteAlarm(index),
              ),
              SizedBox(
                width: 38,
                height: 20,
                child: Transform.scale(
                  scale: 0.5,
                  child: Switch(
                    value: alarm.isActive,
                    onChanged: (value) => controller.toggleAlarm(index),
                    activeColor: AppColors.accentColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
