import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/utils/validators/search_validator.dart';
import 'package:weather_forecast/viewmodels/weather_provider.dart';

class SearchSection extends StatefulWidget {
  final TextEditingController controller;

  const SearchSection({
    super.key,
    required this.controller,
  });

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  // Thêm biến để quản lý trạng thái validate
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a city name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'E.g., New York, London, Tokyo',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                // Thêm errorText từ biến state
                errorText: _errorText,
              ),
              onChanged: (value) {
                // Reset error text khi người dùng gõ
                setState(() {
                  _errorText = null;
                });
              },
            ),
            const SizedBox(height: 10),
            // Consumer để theo dõi trạng thái loading của WeatherProvider
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Kiểm tra validate và cập nhật error text
                      final errorMessage =
                      SearchValidator.validateCityName(widget.controller.text);
                      setState(() {
                        _errorText = errorMessage;
                      });

                      if (errorMessage == null) {
                        weatherProvider.fetchWeatherData(widget.controller.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: weatherProvider.isLoading
                        ? const SizedBox(
                            height: 24, // Chiều cao của biểu tượng xoay tròn
                            width: 24,  // Chiều rộng của biểu tượng xoay tròn
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3.0, // Độ dày của vòng xoay
                            ),
                          )
                        : const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5, // Độ dày của đường kẻ
                    color: Colors.grey, // Màu sắc của đường kẻ
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      color: Colors.grey, // Màu chữ
                      fontSize: 16, // Kích thước chữ
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<WeatherProvider>().fetchWeatherData('Ho Chi Minh');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                child: const Center(
                  child: Text(
                    'Use current location',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
