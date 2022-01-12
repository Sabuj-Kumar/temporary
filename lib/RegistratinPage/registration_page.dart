import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/Input/input.dart';
import 'package:google_map/LogInPage/login_page.dart';
import 'package:google_map/StateManagement/data_controller.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({
    Key? key,
  }) : super(key: key);

  final sizeBox = const SizedBox(height: 20);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var dataFlow = Provider.of<Controller>(context, listen: true);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration PAGE"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleSpacing: 2,
        leading: const Text(""),
      ),
      backgroundColor: const Color(0xff07485e),
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
                      controller: dataFlow.usernameController,
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
                      controller: dataFlow.emailController,
                      prefixIcon: Icons.email_outlined,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hint: "Email",
                      obscured: false,
                    ),
                  ),
                  sizeBox,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 5.0),
                    child: InputField(
                      controller: dataFlow.passController,
                      prefixIcon: Icons.lock_outline,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hint: "Password",
                      obscured: true,
                    ),
                  ),
                  sizeBox,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 5.0),
                    child: InputField(
                      controller: dataFlow.confirmPassController,
                      prefixIcon: Icons.lock_outline,
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hint: "Confirm_Password",
                      obscured: true,
                    ),
                  ),
                  sizeBox,
                  ElevatedButton(
                      onPressed: () async {
                        if (dataFlow.confirmPassController.text.toString() ==
                            dataFlow.passController.text.toString()) {
                          if (formKey.currentState!.validate()) {
                            await dataFlow.apiCall();

                            if (dataFlow.statusCode == 201) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Registration successful"),
                              ));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (cxt) => PersonLogIN()));
                              dataFlow.reset();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Something Wrong"),
                              ));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password not match"),
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
                    "Have An Account.?",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => PersonLogIN()));
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
                        "Log In",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  sizeBox
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
