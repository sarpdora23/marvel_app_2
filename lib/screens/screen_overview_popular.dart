import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:provider/provider.dart';

class CurrentPage extends ChangeNotifier {
  var currentPage = drawerSections.popular;
  void changeCurrentPage(drawerSections replace) {
    currentPage = replace;
    notifyListeners();
  }
}

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

  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<CurrentPage>(
      context,
    );
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
          drawer: AppDrawer(),
        ));
  }
}

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
          MyDrawerList(context)
        ]),
      )),
    );
  }
}

Widget MyDrawerList(BuildContext context) {
  final currentPage = Provider.of<CurrentPage>(
    context,
  );
  return Container(
    padding: EdgeInsets.only(top: 15),
    child: Column(
      children: [
        menuItem(
            0,
            "Popular",
            Icons.view_week,
            currentPage.currentPage == drawerSections.popular ? true : false,
            context),
        menuItem(
            1,
            "Search",
            Icons.search,
            currentPage.currentPage == drawerSections.search ? true : false,
            context),
        menuItem(
            2,
            "Profile",
            Icons.account_circle,
            currentPage.currentPage == drawerSections.profile ? true : false,
            context),
        menuItem(
            3,
            "Watchlist",
            Icons.watch_later,
            currentPage.currentPage == drawerSections.watchlist ? true : false,
            context),
        menuItem(
            4,
            "Lists",
            Icons.grid_3x3,
            currentPage.currentPage == drawerSections.lists ? true : false,
            context),
        menuItem(
            5,
            "Diary",
            Icons.calendar_month,
            currentPage.currentPage == drawerSections.diary ? true : false,
            context),
        menuItem(
            6,
            "Reviews",
            Icons.line_style,
            currentPage.currentPage == drawerSections.reviews ? true : false,
            context),
        menuItem(
            7,
            "Activity",
            Icons.upcoming,
            currentPage.currentPage == drawerSections.activity ? true : false,
            context),
        menuItem(
            8,
            "Settings",
            Icons.settings,
            currentPage.currentPage == drawerSections.settings ? true : false,
            context),
        menuItem(
            9,
            "Sign out",
            Icons.logout,
            currentPage.currentPage == drawerSections.signout ? true : false,
            context),
      ],
    ),
  );
}

Widget menuItem(
    int id, String title, IconData icon, bool selected, BuildContext context) {
  final currentPage = Provider.of<CurrentPage>(context, listen: false);
  return Material(
    color: selected ? appBlueTheme : bgColor,
    child: InkWell(
      onTap: (() {
        currentPage.changeCurrentPage(drawerSections.values[id]);
      }),
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
