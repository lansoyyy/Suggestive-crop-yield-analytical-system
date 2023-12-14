import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:google_api_headers/google_api_headers.dart';
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
import 'package:google_maps_webservice/places.dart' as location1;
import 'package:flutter_google_places/flutter_google_places.dart';
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

  GoogleMapController? mapController;

  final randomGenerator = Random();
  final List<String> crops = [
    'Watermelon',
    'Rice',
    'Coconut',
    'Mango',
    'Stringbean',
    'Sugarcane'
  ];
  final List<int> percentages = [40, 20, 20, 20, 25, 25];

  String getRandomCrop() {
    int totalPercentage = percentages.reduce((a, b) => a + b);
    int randomIndex = randomGenerator.nextInt(totalPercentage);

    int cumulativePercentage = 0;
    for (int i = 0; i < crops.length; i++) {
      cumulativePercentage += percentages[i];
      if (randomIndex < cumulativePercentage) {
        return crops[i];
      }
    }

    // Fallback option if something goes wrong
    return 'Unknown';
  }

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
        zoomControlsEnabled: false,
        buildingsEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: primary,
            onPressed: () {
              String randomCrop = getRandomCrop();

              if (randomCrop == 'Watermelon') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Watermelon is a delicious and refreshing fruit with high water content.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Watermelons are typically grown in warm climates. They require well-drained soil and plenty of sunlight to thrive.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else if (randomCrop == 'Rice') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Rice is a staple food for many cultures and provides a significant source of carbohydrates.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Rice is commonly cultivated in flooded fields. It requires ample water and warm temperatures to grow successfully.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else if (randomCrop == 'Coconut') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Coconut is a versatile fruit with various uses, including food, oil, and fiber.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Coconuts grow well in tropical regions. They need a warm climate, well-drained soil, and regular watering.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else if (randomCrop == 'Mango') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Mango is a tropical fruit known for its sweet and juicy flavor.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Mango trees thrive in warm climates. They require well-drained soil, regular watering, and full sun exposure.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else if (randomCrop == 'Stringbean') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Stringbeans, also known as green beans or snap beans, are a nutritious vegetable.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Stringbeans grow well in moderate temperatures. They require fertile soil, regular watering, and support for climbing.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else if (randomCrop == 'Sugarcane') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text: randomCrop,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextRegular(
                              text:
                                  'Sugarcane is a tall perennial grass known for its high sugar content.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextRegular(
                              text:
                                  'Guide: Sugarcane grows in tropical and subtropical regions. It needs well-drained soil, ample water, and warm temperatures to thrive.',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                          text:
                              'Crop details and guide are not available for the selected crop.',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: TextRegular(
                              text: 'Close',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    });
              }
            },
            child: const Icon(Icons.list),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: primary,
            child: const Icon(Icons.search),
            onPressed: () async {
              location1.Prediction? p = await PlacesAutocomplete.show(
                  mode: Mode.overlay,
                  context: context,
                  apiKey: 'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
                  language: 'en',
                  strictbounds: false,
                  types: [""],
                  decoration: InputDecoration(
                      hintText: 'Search Location',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white))),
                  components: [
                    location1.Component(location1.Component.country, "ph")
                  ]);

              location1.GoogleMapsPlaces places = location1.GoogleMapsPlaces(
                  apiKey: 'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
                  apiHeaders: await const GoogleApiHeaders().getHeaders());

              location1.PlacesDetailsResponse detail =
                  await places.getDetailsByPlaceId(p!.placeId!);

              mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(detail.result.geometry!.location.lat,
                      detail.result.geometry!.location.lng),
                  18.0));

              getApiData(detail.result.geometry!.location.lat,
                  detail.result.geometry!.location.lng);
            },
          ),
        ],
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
                  return StatefulBuilder(builder: (context, setState) {
                    return WeatherBottomSheet(
                      weatherDescription: weatherDescription,
                      humidity: humidity,
                      pressure: pressure,
                      temperatureCelsius: temperatureCelsius,
                      windSpeed: windSpeed,
                      location: '$city, $country',
                    );
                  });
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
}
