

import 'dart:convert';

import 'package:http/http.dart' as http;

class NominatimService{

  static Future<List<Map<String, dynamic>>> search(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5",
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'cooply/1.0 (cooplyio@gmail.com)', // Required by Nominatim
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception("Nominatim search failed: ${response.statusCode}");
    }
  }

}