import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather_history.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper instance = SharedPreferencesHelper._init();
  SharedPreferences? _prefs;

  SharedPreferencesHelper._init();

  // Lấy SharedPreferences instance
  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Lưu lịch sử vào SharedPreferences
  Future<void> insertHistory(WeatherHistory history) async {
    final prefs = await this.prefs;
    final String historyKey = 'weather_history';

    // Lấy dữ liệu lịch sử đã có
    final List<String>? existingHistory = prefs.getStringList(historyKey);

    // Nếu không có dữ liệu trước đó, tạo danh sách mới
    List<String> historyList = existingHistory ?? [];

    // Chuyển dữ liệu lịch sử thành JSON và lưu vào SharedPreferences
    historyList.add(jsonEncode({
      'city': history.city,
      'search_time': history.searchTime.toIso8601String(),
      'weather_data': jsonEncode(history.weatherData.toJson()),
    }));

    // Lưu danh sách lịch sử mới
    await prefs.setStringList(historyKey, historyList);
  }

  // Lấy lịch sử trong ngày
  Future<List<WeatherHistory>> getHistoryForToday() async {
    final prefs = await this.prefs;
    final String historyKey = 'weather_history';

    // Lấy dữ liệu lịch sử
    final List<String>? historyList = prefs.getStringList(historyKey);

    if (historyList == null) return [];

    final List<WeatherHistory> history = [];

    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day).toIso8601String();

    // Duyệt qua tất cả lịch sử, chỉ lấy lịch sử hôm nay
    for (var item in historyList) {
      final data = jsonDecode(item);
      final weatherHistory = WeatherHistory.fromJson(data);

      if (weatherHistory.searchTime.isAfter(DateTime.parse(startOfDay))) {
        history.add(weatherHistory);
      }
    }

    return history;
  }

  // Xóa lịch sử cũ (các bản ghi từ ngày trước)
  Future<void> deleteOldHistory() async {
    final prefs = await this.prefs;
    final String historyKey = 'weather_history';

    // Lấy dữ liệu lịch sử hiện tại
    final List<String>? historyList = prefs.getStringList(historyKey);
    if (historyList == null) return;

    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day).toIso8601String();

    // Chỉ giữ lại các bản ghi từ hôm nay trở đi
    final List<String> updatedHistory = historyList.where((item) {
      final data = jsonDecode(item);
      final weatherHistory = WeatherHistory.fromJson(data);
      return weatherHistory.searchTime.isAfter(DateTime.parse(startOfDay));
    }).toList();

    // Lưu lại lịch sử mới
    await prefs.setStringList(historyKey, updatedHistory);
  }
}
