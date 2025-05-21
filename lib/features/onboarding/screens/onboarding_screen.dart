import 'package:alarmapp/common_widget/onboarding_page.dart';
import 'package:alarmapp/constants/app_assets.dart';
import 'package:alarmapp/constants/app_colors.dart';
import 'package:alarmapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.currentPageIndex.value = index,
            children: const [
              OnboardingPage(
                title: "Sync with Nature's\nRhythm",
                subtitle:
                    "Experience a peaceful transition into the evening with an alarm that aligns with the sunset.Your perfect reminder, always 15 minutes before sundown",
                imagePath: AppAssets.onboarding1,
              ),
              OnboardingPage(
                title: "Effortless & Automatic",
                subtitle:
                    "No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time.",
                imagePath: AppAssets.onboarding2,
              ),
              OnboardingPage(
                title: "Relax & Unwind",
                subtitle: "Hope to take the courage to pursue your dreams.",
                imagePath: AppAssets.onboarding3,
              ),
            ],
          ),

          // Page Indicators and Next Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page Indicator Dots
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPageIndex.value == index
                                ? AppColors.indicatorActive
                                : AppColors.indicatorInactive,
                          ),
                        ),
                      ),
                    )),

                const SizedBox(height: 30),

                // Next/Get Started Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        minimumSize: const Size(double.infinity, 56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        controller.currentPageIndex.value < 2
                            ? 'Next'
                            : 'Get Started',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.location);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
