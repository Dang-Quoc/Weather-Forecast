import 'condition.dart';

class Current {
  final double tempC;
  final Condition condition;
  final double windKph;
  final int humidity;

  Current({
    required this.tempC,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'].toDouble(),
      condition: Condition.fromJson(json['condition']),
      windKph: json['wind_kph'].toDouble(),
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'condition': condition.toJson(),
      'wind_kph': windKph,
      'humidity': humidity,
    };
  }
}
