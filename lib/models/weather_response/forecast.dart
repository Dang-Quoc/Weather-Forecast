import 'forecast_day.dart';

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forecastday': forecastday.map((day) => day.toJson()).toList(),
    };
  }
}
