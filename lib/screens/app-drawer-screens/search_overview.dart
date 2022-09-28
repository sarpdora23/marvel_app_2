import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/screens/screen_overview_popular.dart';
import 'package:marvel_app_2/utilities/colors.dart';

import '../../api/MarvelAPI.dart';

List dummyText = [
  "X-Men Unlimited: X-Men Green #2",
  "Edge of Spider-Verse #4",
  'Iron Cat #4'
].map((e) => e.toLowerCase()).toList();

final TextEditingController searchController = TextEditingController();
List reducedDummyText = [];

class SearchOverview extends StatefulWidget {
  @override
  State<SearchOverview> createState() => _SearchOverviewState();
}

class _SearchOverviewState extends State<SearchOverview> {
  @override
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
        title: TextField(
          onChanged: (value) {
            reducedDummyText = dummyText.where((element) {
              return element.toString().startsWith(
                  searchController.text == '' ? ' ' : searchController.text);
            }).toList();
            setState(() {});
          },
          controller: searchController,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: grayishColor),
              hintText: "Search...",
              border: InputBorder.none),
        ),
        backgroundColor: appBlueTheme,
      ),
      backgroundColor: appBlueTheme,
      body: Container(
        color: bgColor,
        child: ListView.builder(
            itemCount: reducedDummyText.length,
            itemBuilder: ((context, index) {
              return Card(child: Text(reducedDummyText[index]));
            })),
      ),
    );
  }
}
