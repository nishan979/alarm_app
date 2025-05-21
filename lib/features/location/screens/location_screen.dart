import 'package:alarmapp/constants/app_assets.dart';
import 'package:alarmapp/constants/app_colors.dart';
import 'package:alarmapp/features/location/controllers/location_controller.dart';
import 'package:alarmapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = controller.isLoading.value;
    onPressed() {
      controller.requestLocationPermission();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Welcome! Your Personalized Alarm",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Allow us to sync your sunset alarm based on your location.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                  height: 1.5,
                ),
              ),
            ),
            Image.asset(
              AppAssets.locationImage,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D4D4D),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                      mainAxisSize:
                          MainAxisSize.min, // Adjusts width to content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Use Current Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8), // Space between text and icon
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : () {

                // navigate to home screen
                Get.offAllNamed(Routes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D4D4D),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Home",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
