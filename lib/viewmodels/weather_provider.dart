import 'package:flutter/material.dart';
import 'package:weather_forecast/models/weather_response/forecast_day.dart';
import 'package:weather_forecast/models/weather_response/weather_response.dart';
import 'package:weather_forecast/storage/shared_preferences_helper.dart';
import '../services/weather_service.dart';
import '../models/weather_history.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherResponse? _weatherData;
  bool _isLoading = false;
  String? _error;
  final int _fetchDays = 14; // Luôn fetch 14 ngày
  int _displayDays = 4; // Ban đầu chỉ hiển thị 4 ngày

  final List<WeatherHistory> _searchHistory = [];

  WeatherResponse? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get canLoadMore => _weatherData != null && _displayDays < _weatherData!.forecast.forecastday.length;
  List<ForecastDay> get displayedForecastDays => _weatherData?.forecast.forecastday.take(_displayDays).toList() ?? [];
  List<WeatherHistory> get searchHistory => _searchHistory;

  WeatherProvider() {
    loadSearchHistory();
  }

  Future<void> initializeDefaultData() async {
    await fetchWeatherData('Ho Chi Minh');
  }

  Future<void> fetchWeatherData(String city) async {
    _isLoading = true;
    _error = null;
    _displayDays = 4;
    notifyListeners();

    try {
      final data = await _weatherService.getWeather(city, _fetchDays);
      _weatherData = data;
      _addToHistory(city, data);
      _error = null;
    } catch (e) {
      _error = 'Unable to find weather information: $e';
      _weatherData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSearchHistory() async {
    _searchHistory.clear();
    _searchHistory.addAll(await SharedPreferencesHelper.instance.getHistoryForToday());
    notifyListeners();
  }

  void _addToHistory(String city, WeatherResponse data) async {
    final history = WeatherHistory(
      city: city,
      searchTime: DateTime.now(),
      weatherData: data,
    );

    await SharedPreferencesHelper.instance.insertHistory(history);
    await SharedPreferencesHelper.instance.deleteOldHistory();
    await loadSearchHistory();
  }

  void loadFromHistory(WeatherHistory history) {
    _weatherData = history.weatherData;
    _displayDays = 4;
    notifyListeners();
  }

  void loadMoreDays() {
    if (!canLoadMore) return;

    _displayDays += 4;
    if (_displayDays > _weatherData!.forecast.forecastday.length) {
      _displayDays = _weatherData!.forecast.forecastday.length;
    }
    notifyListeners();
  }
}
