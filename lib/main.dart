import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app_2/api/MarvelAPI.dart';
import 'package:marvel_app_2/api/models/Comic.dart';
import 'package:marvel_app_2/screens/screen_login.dart';
import 'package:marvel_app_2/screens/screen_signup.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:provider/provider.dart';

import 'news-scrape/news_scrape.dart';

Future main() async {
  MarvelAPI().fetchCharactersByNumber(80);

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
            create: (context) => PageNumberController()),
        ChangeNotifierProvider<GetNewsData>(create: (context) => GetNewsData()),
      ],
      child: MaterialApp(
        title: 'MarvelBox',
        theme: ThemeData(primarySwatch: Colors.blue, cardColor: cardColor),
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
