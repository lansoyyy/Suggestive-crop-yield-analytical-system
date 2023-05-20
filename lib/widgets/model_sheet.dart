import 'package:flutter/material.dart';

class WeatherBottomSheet extends StatelessWidget {
  var weatherDescription;
  var temperatureCelsius;
  var pressure;
  var humidity;
  var windSpeed;
  var location;

  WeatherBottomSheet(
      {super.key,
      required this.weatherDescription,
      required this.humidity,
      required this.pressure,
      required this.temperatureCelsius,
      required this.windSpeed,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
          const Text(
            'Weather Details',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'QBold'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Location: $location',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Weather Description: $weatherDescription',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Temperature: ${temperatureCelsius.toStringAsFixed(2)}°C',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Pressure: $pressure hPa',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Humidity: $humidity%',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Wind Speed: $windSpeed m/s',
            style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Crop Suggestions:',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'QBold'),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
