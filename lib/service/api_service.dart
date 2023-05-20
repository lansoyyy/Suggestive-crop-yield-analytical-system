import 'package:http/http.dart' as http;

class WeatherService {
  Future<dynamic> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': '67a96ca939095cc12748c226c7d3851c',
        'q': place,
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Can not get weather");
      }
    } catch (e) {
      rethrow;
    }
  }
}
