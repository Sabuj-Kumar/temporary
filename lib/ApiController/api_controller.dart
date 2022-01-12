import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_map/NavigatorWithoutBuildMethod/appnavigator.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiController {
  Future<int> createAccount() async {
    var dataFlow =
        Provider.of<Controller>(appNavigator.context!, listen: false);
    final response = await http.post(
      Uri.parse('https://61bc5c61d8542f00178246d5.mockapi.io/mockapi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': dataFlow.usernameController.text.toString(),
        'email': dataFlow.emailController.text.toString(),
        'password': dataFlow.passController.text.toString(),
        'confirm_password': dataFlow.confirmPassController.text.toString(),
        'salary': '0',
      }),
    );

    // print("Body ${response.body}");
    //print("Body ${response.statusCode.toString()}");

    try {
      if (response.statusCode == 201) {
        debugPrint("okay");
        //dataFlow.getStatusCode(response.statusCode.toString());
        //DataModel data = DataModel.fromJson(jsonDecode(response.body));
        return response.statusCode;
      } else {
        throw Exception('Failed to create album.');
      }
    } catch (e) {
      throw "error found";
    }
  }
}
