import 'package:dio/dio.dart';
import 'package:weather_forecast/models/weather_response/weather_response.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String _apiKey = '62638afa65a841baa9e151649252704';
  final String _baseUrl = 'https://api.weatherapi.com/v1';

  Future<WeatherResponse> getWeather(String city, int days) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast.json',
        queryParameters: {
          'key': _apiKey,
          'q': city,
          'days': days,
          'aqi': 'no',
          'alerts': 'no',
        },
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );
      return WeatherResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Unable to retrieve weather data: $e');
    }
  }
}
