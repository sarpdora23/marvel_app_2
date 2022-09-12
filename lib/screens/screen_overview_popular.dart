import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/utilities/colors.dart';

class PopularScreen extends StatelessWidget {
  static final routeName = '/popular';
  final String appTitle = "Popular";

  final List<Widget> tabList = const [
    Tab(
      child: Text("COMICS"),
    ),
    Tab(
      child: Text("REVIEWS"),
    ),
    Tab(
      child: Text("LISTS"),
    ),
    Tab(
      child: Text("NEWS"),
    ),
  ];

  final List<Widget> tabScreens = [
    Container(
      color: bgColor,
    ),
    Container(color: Colors.blueGrey),
    Container(
      color: bgColor,
    ),
    Container(
      color: Colors.blueGrey,
    ),
  ];

  var currentPage = drawerSections.popular;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: Text(appTitle),
            backgroundColor: appBlueTheme,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: bgColor,
                child: TabBar(tabs: tabList),
              ),
            ),
          ),
          body: TabBarView(children: tabScreens),
          drawer: AppDrawer(currentPage),
        ));
  }
}

class AppDrawer extends StatelessWidget {
  drawerSections currentPage;
  AppDrawer(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          Container(
            height: 200,
            color: appBlueTheme,
          ),
          MyDrawerList(currentPage)
        ]),
      )),
    );
  }
}

Widget MyDrawerList(drawerSections currentPage) {
  return Container(
    padding: EdgeInsets.only(top: 15),
    child: Column(
      children: [
        menuItem(0, "Popular", Icons.view_week,
            currentPage == drawerSections.popular ? true : false),
        menuItem(1, "Search", Icons.search,
            currentPage == drawerSections.search ? true : false),
        menuItem(2, "Profile", Icons.account_circle,
            currentPage == drawerSections.profile ? true : false),
        menuItem(3, "Watchlist", Icons.watch_later,
            currentPage == drawerSections.watchlist ? true : false),
        menuItem(4, "Lists", Icons.grid_3x3,
            currentPage == drawerSections.lists ? true : false),
        menuItem(5, "Diary", Icons.calendar_month,
            currentPage == drawerSections.diary ? true : false),
        menuItem(6, "Reviews", Icons.line_style,
            currentPage == drawerSections.diary ? true : false),
        menuItem(7, "Activity", Icons.upcoming,
            currentPage == drawerSections.activity ? true : false),
        menuItem(8, "Settings", Icons.settings,
            currentPage == drawerSections.settings ? true : false),
        menuItem(9, "Sign out", Icons.logout,
            currentPage == drawerSections.signout ? true : false),
      ],
    ),
  );
}

Widget menuItem(int id, String title, IconData icon, bool selected) {
  return Material(
    color: bgColor,
    child: InkWell(
      onTap: (() => {}),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    ),
  );
}

enum drawerSections {
  popular,
  search,
  profile,
  watchlist,
  lists,
  diary,
  reviews,
  activity,
  settings,
  signout
}
