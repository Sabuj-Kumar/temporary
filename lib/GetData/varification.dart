import 'package:google_map/Model/data_model.dart';
import 'package:google_map/NavigatorWithoutBuildMethod/appnavigator.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:provider/provider.dart';
import 'data_get_api.dart';

class Validation {
  var value = Provider.of<Controller>(appNavigator.context!, listen: false);
  List<DataModel> list = [];

  Future<void> getData() async {
    try {
      await FetchData().getData().then((val) {
        value.list = val;
      }).catchError((e) {});
    } catch (e) {
      throw "Data Not Come";
    }
  }

  bool LogInValidation() {
    for (var val in value.list) {
      print(val);
      if (value.usernameController.text == val.username &&
          val.password == value.passController.text) {
        value.idController.text = val.id.toString();
        return true;
      }
    }

    return false;
  }

  bool SalaryVerification() {
    for (var val in value.list) {
      if (value.usernameController.text == val.username) {
        value.latitudeController.text = val.latitude.toString();
        value.longitudeController.text = val.longitude.toString();
        value.idController.text = val.id.toString();
        return true;
      }
    }
    return false;
  }
}
