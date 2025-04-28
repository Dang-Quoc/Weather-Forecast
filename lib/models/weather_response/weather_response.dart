import 'location.dart';
import 'current.dart';
import 'forecast.dart';

class WeatherResponse {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
      'forecast': forecast.toJson(),
    };
  }
}
