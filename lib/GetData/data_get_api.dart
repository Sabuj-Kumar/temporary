import 'dart:convert';
import 'package:google_map/Model/data_model.dart';
import 'package:http/http.dart' as http;

class FetchData {
  Future<dynamic> getData() async {
    try {
      final response = await http.get(
          Uri.parse('https://61bc5c61d8542f00178246d5.mockapi.io/mockapi'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw "No connection";
    }
  }
}
