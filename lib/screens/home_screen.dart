import 'dart:async';
import 'dart:convert';

import 'package:crop_analytical_system/screens/auth/login_page.dart';
import 'package:crop_analytical_system/utils/colors.dart';
import 'package:crop_analytical_system/utils/keys.dart';
import 'package:crop_analytical_system/widgets/drawer_widget.dart';
import 'package:crop_analytical_system/widgets/model_sheet.dart';
import 'package:crop_analytical_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../utils/api_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.2477, 122.9888),
    zoom: 14.4746,
  );

  String location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextRegular(
          text: 'Home',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: TextBold(
                            text: 'Logout Confirmation',
                            color: Colors.black,
                            fontSize: 14),
                        content: TextRegular(
                            text: 'Are you sure you want to logout?',
                            color: Colors.black,
                            fontSize: 16),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: TextBold(
                                text: 'Close',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: TextBold(
                                text: 'Continue',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ],
                      ));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GoogleMap(
        onTap: (argument) {
          getApiData(argument.latitude, argument.longitude);
        },
        buildingsEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  getApiData(lat, long) async {
    var uri = '$apiEnpoint?lat=$lat&lon=$long&appid=$apiKey';
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // Request was successful
        var data = json.decode(response.body);
        var weatherDescription = data['weather'][0]['description'];
        var temperatureKelvin = data['main']['temp'];
        var temperatureCelsius =
            temperatureKelvin - 273.15; // Convert from Kelvin to Celsius
        var pressure = data['main']['pressure'];
        var humidity = data['main']['humidity'];
        var windSpeed = data['wind']['speed'];

        print('Weather Description: $weatherDescription');
        print('Temperature: ${temperatureCelsius.toStringAsFixed(2)}°C');
        print('Pressure: $pressure');
        print('Humidity: $humidity');
        print('Wind Speed: $windSpeed');

        // Suggest crops based on weather conditions
        suggestCrops(
            weatherDescription, temperatureCelsius, pressure, humidity);

        // Show success snackbar
        showSnackbar('Request successful');

        try {
          List<Placemark> placemarks =
              await placemarkFromCoordinates(lat, long);
          if (placemarks.isNotEmpty) {
            Placemark placemark = placemarks.first;
            String? city = placemark.locality;
            String? country = placemark.country;
            String? address = placemark.street;

            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return WeatherBottomSheet(
                    weatherDescription: weatherDescription,
                    humidity: humidity,
                    pressure: pressure,
                    temperatureCelsius: temperatureCelsius,
                    windSpeed: windSpeed,
                    location: '$city, $country',
                  );
                });
          } else {
            print('No location data found for the given coordinates.');
          }
        } catch (e) {
          print('An error occurred: $e');
        }
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');

        // Show error snackbar
        showSnackbar('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred
      print('Error: $e');

      // Show error snackbar
      showSnackbar('An error occurred');
    }
  }

  void showSnackbar(String message) {
    // Replace with your own snackbar implementation
    print('Snackbar: $message');
    // Example using Flutter's ScaffoldMessenger for showing a snackbar
    // ScaffoldMessenger.
    //
    //of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void suggestCrops(String weatherDescription, double temperature, int pressure,
      int humidity) {
    // Add your crop suggestion logic here based on the weather conditions
    // You can check the weather description, temperature, pressure, humidity, etc.
    // and suggest appropriate crops

    // Example crop suggestions based on weather conditions
    if (temperature > 25 && weatherDescription.contains('rain')) {
      print('Suggested Crop: Rice');
    } else if (temperature > 30 && pressure > 1015) {
      print('Suggested Crop: Corn');
    } else {
      print('No specific crop suggestion for current weather conditions.');
    }
  }
}
