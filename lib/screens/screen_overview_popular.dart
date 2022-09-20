import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/main.dart';
import 'package:marvel_app_2/news-scrape/news_scrape.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/activity_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/lists_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/profile_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/reviews_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/search_overview.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/settings_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/signout_screen.dart';
import 'package:marvel_app_2/screens/app-drawer-screens/watchlist_screen.dart';
import 'package:marvel_app_2/screens/inapp_browser.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'add_comic_screen.dart';
import 'app-drawer-screens/diary_screen.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    final news = Provider.of<GetNewsData>(context, listen: false);
    myFuture = news.getNews();
    super.initState();
  }

  late final Future myFuture;

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<GetNewsData>(context, listen: false);

    return FutureBuilder(
        future: myFuture,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: bgColor,
                child: SingleChildScrollView(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: news.titles.length,
                      itemBuilder: ((context, index) {
                        return CustomNewsCard(
                          description:
                              snapshot.data[index]['description'] ?? "-",
                          image: snapshot.data[index]['imagePaths'],
                          link: snapshot.data[index]['links'],
                          title: snapshot.data[index]['titles'],
                        );
                      })),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}

class CustomNewsCard extends StatelessWidget {
  late String image;
  late String title;
  late String description;
  late String link;

  double _containerHeight = 200;
  double _containerWidth = 400;

  CustomNewsCard(
      {required this.image,
      required this.title,
      required this.description,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: ((context) => InApppBrowser(link)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: _containerWidth,
            child: Column(children: [
              Image.network(image, fit: BoxFit.scaleDown,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else
                  // ignore: curly_braces_in_flow_control_structures
                  return SizedBox(
                      child: Shimmer.fromColors(
                          baseColor: bgColor,
                          highlightColor: Colors.white.withOpacity(0.2),
                          child: Container(
                            color: grayishColor,
                            height: _containerHeight,
                            width: _containerWidth,
                          )));
              }),
              Container(
                width: _containerWidth,
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: grayishColor),
                    )
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class PageNumberController extends ChangeNotifier {
  var currentPage = drawerSections.popular;
  var previousPage = drawerSections.popular;
  void changeCurrentPage(drawerSections replace) {
    previousPage = currentPage;
    currentPage = replace;
    notifyListeners();
  }
}

class PopularScreen extends StatefulWidget {
  static final routeName = '/popular';

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final String appTitle = "Popular";
  late final List<Widget> tabScreens;

  @override
  void initState() {
    // TODO: implement initState
    tabScreens = [
      Container(
        color: bgColor,
      ),
      Container(color: Colors.blueGrey),
      Container(
        color: bgColor,
      ),
      Center(
          child: Container(
              constraints: BoxConstraints.expand(),
              color: bgColor,
              height: 300,
              child: News()))
    ];
  }

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
        if (pageController.currentPage == drawerSections.values[id]) return;
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
