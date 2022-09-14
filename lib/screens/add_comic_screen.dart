import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/utilities/colors.dart';

class AddComicScreen extends StatelessWidget {
  const AddComicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text("Add a film"),
        backgroundColor: appBlueTheme,
      ),
      backgroundColor: appBlueTheme,
      body: AddComicScreenBody(),
    );
  }
}

class AddComicScreenBody extends StatelessWidget {
  const AddComicScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
    );
  }
}
