// import 'package:geolocator/geolocator.dart';
// import 'package:survey/utils/utils.dart';
// class LocationService {
//   Future<Position?> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Utils.showSnackBar("Location services are disabled. Please enable location.", SnackType.error);
//       return null; // Stop here, do not proceed
//     }
//
//     // Check permission status
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Utils.showSnackBar("Location permission denied.", SnackType.error);
//         return null; // Stop here
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       Utils.showSnackBar("Location permission permanently denied. Please enable it from settings.", SnackType.error);
//       return null; // Stop here
//     }
//
//     // All checks passed, get current location
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }
// }









import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  static Future<Map<String, dynamic>> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        "locationIsPicked": false,
        "lat": "",
        "long": "",
        "msg": "Please enable your device location"
      };
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "locationIsPicked": false,
          "lat": "",
          "long": "",
          "msg": "Please allow your device location"
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        "locationIsPicked": false,
        "lat": "",
        "long": "",
        "msg": "Please allow your device location"
      };
    }

    try {
      // Try getting the last known location for a faster response
      Position? lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        print("-----Last Known Location -----");
        print(lastKnown.latitude.toString());
        print(lastKnown.longitude.toString());

        return {
          "locationIsPicked": true,
          "lat": lastKnown.latitude.toString(),
          "long": lastKnown.longitude.toString(),
          "msg": "Using last known location"
        };
      }

      // Get current location with a timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium, // Lower accuracy for faster response
        timeLimit: const Duration(seconds: 10),  // Set timeout to 10 sec
      );

      print("-----Current Known Location -----");
      print(position.latitude.toString());
      print(position.longitude.toString());

      return {
        "locationIsPicked": true,
        "lat": position.latitude.toString(),
        "long": position.longitude.toString(),
        "msg": "Location access successfully"
      };
    } catch (e) {
      return {
        "locationIsPicked": false,
        "lat": "",
        "long": "",
        "msg": "Failed to get location: $e"
      };
    }
  }
}



