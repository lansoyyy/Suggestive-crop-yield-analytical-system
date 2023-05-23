import 'package:crop_analytical_system/data/crop_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherBottomSheet extends StatefulWidget {
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
  State<WeatherBottomSheet> createState() => _WeatherBottomSheetState();
}

class _WeatherBottomSheetState extends State<WeatherBottomSheet> {
  @override
  void initState() {
    super.initState();
    cropSuggestion();
  }

  late DateTime date = DateTime.now();
  late DateTime date2 = DateTime.now();
  int month = 0;
  bool completed = false;

  String cropData = '';

  void cropSuggestion() {
    for (int i = 0; i < dataList.length; i++) {
      if (widget.location.toUpperCase() == dataList[i]['location']) {
        for (int j = 0; j < dataList[i]['crops'].length; j++) {
          if (dataList[i]['crops'][j]['duration'] == month) {
            setState(() {
              cropData = dataList[i]['crops'][j]['name'];
            });
          } else {
            setState(() {
              cropData = 'No available crop for that data';
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QBold'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Location: ${widget.location}',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Weather Description: ${widget.weatherDescription}',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Temperature: ${widget.temperatureCelsius.toStringAsFixed(2)}°C',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Pressure: ${widget.pressure} hPa',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Humidity: ${widget.humidity}%',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Wind Speed: ${widget.windSpeed} m/s',
              style: const TextStyle(fontSize: 16, fontFamily: 'QRegular'),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  setState(() {
                    date = selectedDate;
                    month = selectedDate.month;
                  });
                }
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                      ),
                      hintText: 'From: ${DateFormat.yMMMd().format(date)}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  setState(() {
                    date2 = selectedDate;
                    completed = true;
                  });
                }
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                      ),
                      hintText: 'To: ${DateFormat.yMMMd().format(date2)}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Visibility(
              visible: completed,
              child: Text(
                'Crop Suggestions: $cropData',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QBold'),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
