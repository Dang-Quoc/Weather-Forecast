import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/viewmodels/weather_provider.dart';
import 'package:weather_forecast/views/widgets/subscription_form.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[800]!, Colors.blue[200]!],
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.wb_sunny,
                        size: 40,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Weather Forecast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Trang chủ
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // Thêm nút đăng ký thông báo
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Subscribe to notifications'),
                onTap: () {
                  Navigator.pop(context); // Đóng drawer trước
                  SubscriptionForm.show(
                    context,
                    weatherProvider.weatherData?.location.name ?? 'Ho Chi Minh',
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('Default city'),
                subtitle: const Text('Ho Chi Minh City'),
                onTap: () {
                  weatherProvider.initializeDefaultData();
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              // Lịch sử tìm kiếm
              if (weatherProvider.searchHistory.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Histories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...weatherProvider.searchHistory.reversed.map((history) => ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(history.city),
                      subtitle: Text(
                        '${history.weatherData.current.tempC}°C - ${history.searchTime.hour}:${history.searchTime.minute}',
                      ),
                      onTap: () {
                        weatherProvider.loadFromHistory(history);
                        Navigator.pop(context); // Đóng drawer
                      },
                    )),
              ],
            ],
          );
        },
      ),
    );
  }
}
