import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxString currentAddress = 'Fetching location...'.obs;

  Future<void> requestLocationPermission() async {
    try {
      isLoading.value = true;

      var status = await Geolocator.checkPermission();
      if (status == LocationPermission.deniedForever) {
        Get.snackbar('Permission Required', 'Please enable location permissions in settings');
        return;
      }

      if (status == LocationPermission.denied) {
        status = await Geolocator.requestPermission();
        if (status == LocationPermission.denied) {
          Get.snackbar('Permission Required', 'Location permission is required to continue.');
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      currentPosition.value = position;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        currentAddress.value = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      } else {
        currentAddress.value = "Address not found";
      }

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
