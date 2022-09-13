import 'package:flutter/material.dart';
import 'package:marvel_app_2/api/MarvelAPI.dart';
import 'package:marvel_app_2/screens/screen_login.dart';
import 'package:marvel_app_2/screens/screen_signup.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageNumberController>(
            create: (context) => PageNumberController())
      ],
      child: MaterialApp(
        title: 'MarvelBox',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUpScreen(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          PopularScreen.routeName: (context) => PopularScreen()
        },
      ),
    );
  }
}
