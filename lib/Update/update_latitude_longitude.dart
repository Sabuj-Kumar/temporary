import 'dart:convert';
import 'package:google_map/NavigatorWithoutBuildMethod/appnavigator.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UpdateLatitudeLongitude {
  var value = Provider.of<Controller>(appNavigator.context!, listen: false);

  Future<int> updateInfo(int id, double? latitude, double? longitude) async {
    final response = await http.put(
      Uri.parse('https://61bc5c61d8542f00178246d5.mockapi.io/mockapi/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }),
    );

    try {
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception('Failed to update album.');
      }
    } catch (e) {
      throw "Salary Not Send";
    }
  }
}
