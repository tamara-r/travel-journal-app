import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_journal/features/journey/domain/models/country_model.dart';

class CountryDetailsService {
  static Future<CountryModel> fetchByCode(String code) async {
    final url = 'https://restcountries.com/v3.1/alpha/$code';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return CountryModel.fromV3Json(data[0]);
    } else {
      throw Exception('Failed to fetch country details');
    }
  }
}
