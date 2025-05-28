import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocation_states.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final LocationSettings locationSettings;

  GeolocationCubit({
    bool trackContinuously = false,
    this.locationSettings = const LocationSettings(accuracy: LocationAccuracy.best),
  }) : super(LocationLoadingState()) {
    _initialize().then((permission) {
      if (permission) {
        getUserLocation();
      }

      if (trackContinuously) {
        trackUserLocation();
      }
    });
  }

  Future<bool> _initialize() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(PermissionDeniedState('Location services are disabled.'));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        emit(PermissionDeniedState('Location permissions are denied'));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(PermissionDeniedState(
          'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  _newLocation(Position position) async {
    emit(LocationLoadedState(position));
  }

  getUserLocation() async {
    final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    _newLocation(position);
  }

  trackUserLocation() {
    // Listen to user location changes
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((userPosition) {
      if (!isClosed) {
        _newLocation(userPosition);
      }
    });
  }
}
