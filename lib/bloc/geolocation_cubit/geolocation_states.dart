import 'package:geolocator/geolocator.dart';

sealed class GeolocationState {}

class LocationLoadingState extends GeolocationState {}

class PermissionDeniedState extends GeolocationState {
  final String message;

  PermissionDeniedState(this.message);
}

class LocationLoadedState extends GeolocationState {
  final Position position;

  LocationLoadedState(this.position);
}
