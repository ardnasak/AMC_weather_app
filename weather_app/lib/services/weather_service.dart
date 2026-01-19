import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';

class WeatherService {
  static const String apikey = "";
  static const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";

  static Future<Weather> getWeather(String cityName) async {
    try {
      final String url = '$apiUrl?q=$cityName&appid=$apikey&units=metric';
      final http.Response response = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Weather.fromJson(data);
      }
      else if (response.statusCode == 404) {
        throw Exception('City not found');
      }
      else {
        throw Exception(
            'Failed to load weather data. Status ${response.statusCode}');
      }
    }
    catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
