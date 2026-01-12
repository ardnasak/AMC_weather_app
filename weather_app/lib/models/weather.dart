class Weather {
  final  String city;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;

Weather({
  required this.city,
  required this.temperature,
  required  this.description,
  required this.humidity,
  required this.windSpeed,
});


  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      // Provides a default value if 'name' is missing
      city: json['name'] ?? 'Unknown City',

      // 1. Corrects the 'temp' typo.
      // 2. Safely checks if 'main' exists before accessing 'temp'.
      temperature: (json['main'] != null ? json['main']['temp'] ?? 0 : 0).toDouble(),

      // 3. Safely checks if 'weather' is a list and not empty before accessing its elements.
      description: (json['weather'] != null && (json['weather'] as List).isNotEmpty)
          ? json['weather'][0]['main'] ?? 'No description'
          : 'No description',

      // Safely checks if 'main' exists before accessing 'humidity'.
      humidity: (json['main'] != null ? json['main']['humidity'] ?? 0 : 0),

      // Safely checks if 'wind' exists before accessing 'speed'.
      windSpeed: (json['wind'] != null ? json['wind']['speed'] ?? 0 : 0).toDouble(),


  );
}
}