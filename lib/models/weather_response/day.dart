import 'condition.dart';

class Day {
  final double avgtempC;
  final double maxwindKph;
  final double avghumidity;
  final Condition condition;

  Day({
    required this.avgtempC,
    required this.maxwindKph,
    required this.avghumidity,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      avgtempC: json['avgtemp_c'].toDouble(),
      maxwindKph: json['maxwind_kph'].toDouble(),
      avghumidity: json['avghumidity'].toDouble(),
      condition: Condition.fromJson(json['condition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avgtemp_c': avgtempC,
      'maxwind_kph': maxwindKph,
      'avghumidity': avghumidity,
      'condition': condition.toJson(),
    };
  }
}
