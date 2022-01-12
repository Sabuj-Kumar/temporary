import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LogInPage/login_page.dart';
import 'NavigatorWithoutBuildMethod/appnavigator.dart';
import 'StateManagement/data_controller.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Controller>(create: (_) => Controller()),
      ],
      child: MaterialApp(
        navigatorKey: appNavigator.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Google Map",
        theme: ThemeData(primaryColor: const Color(0xff07485e)),
        home: PersonLogIN(),
      ),
    );
  }
}
