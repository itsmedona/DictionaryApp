import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/dictionary_model/dictionary_model.dart';

class ApiController {
  static const String baseUrl =
      "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static Future<DictionaryModel> fetchMeaning(String word) async {
    final response = await http.get(Uri.parse("$baseUrl$word"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DictionaryModel.fromJson(data[0]);
    } else {
      throw Exception("Failed to load meaning");
    }
  }
}
