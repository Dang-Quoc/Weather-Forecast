import 'day.dart';

class ForecastDay {
  final String date;
  final Day day;

  ForecastDay({required this.date, required this.day});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day': day.toJson(),
    };
  }
}
