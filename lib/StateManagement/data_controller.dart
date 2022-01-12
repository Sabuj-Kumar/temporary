import 'package:flutter/cupertino.dart';
import 'package:google_map/ApiController/api_controller.dart';
import 'package:google_map/Model/data_model.dart';

class Controller extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController idController = TextEditingController();
  List<DataModel> list = [];
  int? _statusCode;

  Future apiCall() async {
    _statusCode = null;
    var res = await ApiController().createAccount();
    _statusCode = res;
    notifyListeners();
  }

  reset() {
    usernameController.clear();
    passController.clear();
    confirmPassController.clear();
    emailController.clear();
    salaryController.clear();
    latitudeController.clear();
    longitudeController.clear();
    idController.clear();
    notifyListeners();
  }

  int get statusCode => _statusCode!;
}
