import 'package:flutter/material.dart';
import 'package:google_map/GetData/varification.dart';
import 'package:google_map/Input/input.dart';
import 'package:google_map/LogInPage/login_page.dart';
import 'package:google_map/Map/google_map.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:google_map/Update/updata.dart';
import 'package:provider/provider.dart';

class SalaryInput extends StatefulWidget {
  const SalaryInput({Key? key}) : super(key: key);

  @override
  State<SalaryInput> createState() => _SalaryInputState();
}

class _SalaryInputState extends State<SalaryInput> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var input = Provider.of<Controller>(context, listen: true);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        titleSpacing: 1,
        title: Text(
          "Employee.",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Text("Person Name and Salary",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: height * 0.05,
            ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 5.0),
                        child: InputField(
                          controller: input.salaryController,
                          prefixIcon: Icons.money,
                          inputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          hint: "Salary",
                          obscured: true,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                Validation().SalaryVerification()) {
                              var statusCode = await UpdateSalary().updateInfo(
                                  int.parse(
                                      input.idController.text.toString()));

                              if (statusCode == 200) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("log in successful"),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cxt) => PersonLogIN()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Salary Not Entry"),
                                ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.tealAccent,
                              shadowColor: Colors.white70,
                              side: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 80, right: 80, top: 10, bottom: 10)),
                          child: const Text(
                            "Update Salary",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (Validation().SalaryVerification()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("See Locations"),
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cxt) => GooggleMap(
                                            latitude: double.parse(input
                                                .latitudeController.text
                                                .toString()),
                                            longitude: double.parse(input
                                                .longitudeController.text
                                                .toString()),
                                          )));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.tealAccent,
                              shadowColor: Colors.white70,
                              side: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 80, right: 80, top: 10, bottom: 10)),
                          child: const Text(
                            "See Entry",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ))
                    ])),
          ],
        ),
      ),
    );
  }
}
