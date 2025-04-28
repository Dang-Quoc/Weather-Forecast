import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/models/weather_response/forecast_day.dart';
import 'package:weather_forecast/viewmodels/weather_provider.dart';

class ForecastSection extends StatelessWidget {
  const ForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        final forecastDays = weatherProvider.displayedForecastDays;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weather forecast',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Sử dụng GridView để thay thế Wrap
            GridView.builder(
              shrinkWrap: true, // Sử dụng GridView trong một cột, không scroll được
              physics: const NeverScrollableScrollPhysics(), // Ngừng scroll nếu không cần thiết
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context), // Tự động thay đổi số cột dựa trên màn hình
                crossAxisSpacing: 16.0, // Khoảng cách ngang giữa các phần tử
                mainAxisSpacing: 16.0, // Khoảng cách dọc giữa các phần tử
                childAspectRatio: 0.75, // Tỷ lệ của mỗi phần tử, có thể thay đổi tùy thuộc vào mục đích
              ),
              itemCount: forecastDays.length,
              itemBuilder: (context, index) {
                return _buildForecastDay(forecastDays[index]);
              },
            ),
            _buildLoadMoreButton(context, weatherProvider),
          ],
        );
      },
    );
  }

  // Hàm này sẽ tự động trả về số cột phụ thuộc vào kích thước màn hình
  int _getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 700) {
      return 1; // Trên màn hình nhỏ, có 2 cột
    } else if (width < 1200) {
      return 2; // Trên màn hình trung bình, có 3 cột
    } else {
      return 4; // Trên màn hình lớn, có 4 cột
    }
  }

  Widget _buildForecastDay(ForecastDay day) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Giữ cho chiều cao tự động điều chỉnh
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day.date,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),  // Khoảng cách giữa các phần tử
          CachedNetworkImage(
            imageUrl: day.day.condition.icon,
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 8),  // Khoảng cách giữa ảnh và thông tin dưới
          Text(
            'Temp: ${day.day.avgtempC}°C',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4), // Thêm khoảng cách nhỏ giữa các dòng
          Text(
            'Wind: ${day.day.maxwindKph} KPH',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4), // Thêm khoảng cách nhỏ giữa các dòng
          Text(
            'Humidity: ${day.day.avghumidity}%',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),  // Thêm khoảng cách cuối cùng
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(BuildContext context, WeatherProvider weatherProvider) {
    if (!weatherProvider.canLoadMore) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: weatherProvider.isLoading
            ? null
            : weatherProvider.loadMoreDays,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Load more 4 days',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
