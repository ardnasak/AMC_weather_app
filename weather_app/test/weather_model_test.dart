import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather.dart'; // Adjust the import path to your weather model

void main() {
  group('Weather.fromJson', () {
    test('should correctly parse JSON data for Manila', () {
      // 1. Arrange: Define a realistic JSON response string for Manila.
      // This sample is structured like a real response from the OpenWeatherMap API.
      const String manilaJsonString = '''
      {
        "coord": {
          "lon": 120.9822,
          "lat": 14.6042
        },
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 30.9,
          "feels_like": 37.9,
          "temp_min": 30.1,
          "temp_max": 31.5,
          "pressure": 1009,
          "humidity": 70
        },
        "visibility": 10000,
        "wind": {
          "speed": 3.6,
          "deg": 130
        },
        "clouds": {
          "all": 75
        },
        "dt": 1629876000,
        "sys": {
          "type": 1,
          "id": 8160,
          "country": "PH",
          "sunrise": 1629841800,
          "sunset": 1629886200
        },
        "timezone": 28800,
        "id": 1701668,
        "name": "Manila",
        "cod": 200
      }
      ''';

      // 2. Act: Decode the JSON string and pass it to the Weather.fromJson factory.
      final Map<String, dynamic> jsonMap = json.decode(manilaJsonString);
      final Weather weather = Weather.fromJson(jsonMap);

      // 3. Assert: Verify that the Weather object's properties match the JSON data.
      expect(weather, isA<Weather>());
      expect(weather.city, 'Manila');
      expect(weather.temperature, 30.9);
    });

    test('should handle JSON with missing optional fields gracefully', () {
      // Arrange: JSON missing the 'weather' list, which can happen.
      const String incompleteJsonString = '''
      {
        "coord": {
          "lon": 120.9822,
          "lat": 14.6042
        },
        "main": {
          "temp": 30.9
        },
        "name": "Manila"
      }
      ''';

      // Act
      final Map<String, dynamic> jsonMap = json.decode(incompleteJsonString);
      final Weather weather = Weather.fromJson(jsonMap);

      // Assert: Check that required fields are parsed and optional ones are null or have default values.
      // This depends on the implementation of your Weather.fromJson constructor.
      expect(weather.city, 'Manila');
      expect(weather.temperature, 30.9);

    });
  });
}
