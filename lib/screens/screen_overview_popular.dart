import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/activity_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/lists_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/profile_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/reviews_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/search_overview.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/settings_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/signout_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/watchlist_screen.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:provider/provider.dart';

import 'add_comic_screen.dart';
import 'app-drawer-screens/diary_screen.dart';

class PageNumberController extends ChangeNotifier {
  var currentPage = drawerSections.popular;
  var previousPage = drawerSections.popular;
  void changeCurrentPage(drawerSections replace) {
    previousPage = currentPage;
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
    final pageController = Provider.of<PageNumberController>(
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
                  color: appBlueTheme,
                  child: TabBar(
                    tabs: tabList,
                  ),
                ),
              ),
            ),
            body: TabBarView(children: tabScreens),
            drawer: AppDrawer(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: themeGreen,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => AddComicScreen())),
              ),
            )));
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
  final pageController = Provider.of<PageNumberController>(
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
            pageController.currentPage == drawerSections.popular ? true : false,
            context),
        menuItem(
            1,
            "Search",
            Icons.search,
            pageController.currentPage == drawerSections.search ? true : false,
            context),
        menuItem(
            2,
            "Profile",
            Icons.account_circle,
            pageController.currentPage == drawerSections.profile ? true : false,
            context),
        menuItem(
            3,
            "Watchlist",
            Icons.watch_later,
            pageController.currentPage == drawerSections.watchlist
                ? true
                : false,
            context),
        menuItem(
            4,
            "Lists",
            Icons.grid_3x3,
            pageController.currentPage == drawerSections.lists ? true : false,
            context),
        menuItem(
            5,
            "Diary",
            Icons.calendar_month,
            pageController.currentPage == drawerSections.diary ? true : false,
            context),
        menuItem(
            6,
            "Reviews",
            Icons.line_style,
            pageController.currentPage == drawerSections.reviews ? true : false,
            context),
        menuItem(
            7,
            "Activity",
            Icons.upcoming,
            pageController.currentPage == drawerSections.activity
                ? true
                : false,
            context),
        menuItem(
            8,
            "Settings",
            Icons.settings,
            pageController.currentPage == drawerSections.settings
                ? true
                : false,
            context),
        menuItem(
            9,
            "Sign out",
            Icons.logout,
            pageController.currentPage == drawerSections.signout ? true : false,
            context),
      ],
    ),
  );
}

Widget menuItem(
    int id, String title, IconData icon, bool selected, BuildContext context) {
  final pageController =
      Provider.of<PageNumberController>(context, listen: false);
  return Material(
    color: selected ? appBlueTheme : bgColor,
    child: InkWell(
      onTap: (() {
        print(id);
        pageController.changeCurrentPage(drawerSections.values[id]);
        Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Screens[id])))
            .then((value) =>
                pageController.changeCurrentPage(pageController.previousPage));
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

List<Widget> Screens = [
  PopularScreen(),
  SearchOverview(),
  ProfileScreen(),
  WatchlistScreen(),
  ListsScreen(),
  DiaryScreen(),
  ReviewsScreen(),
  ActivityScreen(),
  SettingsScreen(),
  SignoutScreen(),
  AddComicScreen()
];
