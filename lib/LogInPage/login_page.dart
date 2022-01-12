import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/GetData/data_get_api.dart';
import 'package:google_map/GetData/varification.dart';
import 'package:google_map/Input/input.dart';
import 'package:google_map/Model/data_model.dart';
import 'package:google_map/RegistratinPage/registration_page.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:google_map/entry/entry.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PersonLogIN extends StatefulWidget {
  PersonLogIN({Key? key}) : super(key: key);

  @override
  State<PersonLogIN> createState() => _PersonLogINState();
}

class _PersonLogINState extends State<PersonLogIN> {
  final sizeBox = const SizedBox(height: 20);

  final formKey = GlobalKey<FormState>();

  Validation data = Validation();
  List<DataModel> list = [];
  @override
  void initState() {
    _getAllData();
    super.initState();
  }

  _getAllData() async {
    await FetchData().getData().then((v) {
      for (var value in v) {
        list.add(DataModel.fromJson(value));
      }
      print("list Length ${list.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var input = Provider.of<Controller>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOG IN PAGE"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleSpacing: 2,
        leading: const Text(""),
      ),
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            const Material(
              shape: CircleBorder(),
              shadowColor: Colors.indigoAccent,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Icon(Icons.person, size: 60),
                ),
              ),
            ),
            sizeBox,
            sizeBox,
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 5.0),
                    child: InputField(
                      controller: input.usernameController,
                      prefixIcon: Icons.account_circle,
                      inputAction: TextInputAction.next,
                      hint: "Username",
                      obscured: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  sizeBox,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 5.0),
                    child: InputField(
                      controller: input.passController,
                      prefixIcon: Icons.lock_outline,
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hint: "Password",
                      obscured: true,
                    ),
                  ),
                  sizeBox,
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("log in successful"),
                          ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (cxt) => const Entry()));
                          input.reset();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("login Not successful"),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent,
                          shadowColor: Colors.white70,
                          side: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.only(
                              left: 80, right: 80, top: 10, bottom: 10)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  sizeBox,
                  sizeBox,
                  const Text(
                    "Please Create An Account.",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => RegistrationPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shadowColor: Colors.white70,
                          side: const BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10)),
                      child: const Text(
                        "Create One.",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
