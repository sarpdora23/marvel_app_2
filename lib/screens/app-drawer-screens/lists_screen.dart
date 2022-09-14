import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/utilities/colors.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Lists"),
        backgroundColor: appBlueTheme,
      ),
      backgroundColor: appBlueTheme,
      body: ListsBody(),
    );
  }
}

class ListsBody extends StatelessWidget {
  const ListsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
    );
  }
}
