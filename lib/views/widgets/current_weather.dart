import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_forecast/models/weather_response/weather_response.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherResponse weatherData;

  const CurrentWeather({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${weatherData.location.name} (${weatherData.location.localtime})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              CachedNetworkImage(
                imageUrl: weatherData.current.condition.icon,
                width: 75,
                height: 75,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Temperature: ${weatherData.current.tempC}°C',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'Wind: ${weatherData.current.windKph} KPH',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'Humidity: ${weatherData.current.humidity}%',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
