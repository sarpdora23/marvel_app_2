import 'dart:convert';
import "dart:io";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:html/parser.dart" as parser;

class GetNewsData extends ChangeNotifier {
  final HDRS = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36',
    "Upgrade-Insecure-Requests": "1",
    "DNT": "1",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Accept-Encoding": "gzip, deflate"
  };

  String apiLink =
      "https://www.marvel.com/v1/pagination/content_grid_cards?componentId=552916&offset=1&limit=100";

  String imageLink = "https://terrigen-cdn-dev.marvel.com/content/prod/1x/";
  String domain = "https://www.marvel.com";

  List titles = [];
  List imagePaths = [];
  List descriptions = [];
  List links = [];

  Map _news = {};

  bool isLoaded = false;

  Future getNews() async {
    if (isLoaded == true) return;
    var urlApi = apiLink;
    var url = Uri.parse(urlApi);
    var res = await http.get(url, headers: HDRS);
    final body = res.body;
    final document = parser.parse(body);
    if (document.body != null) {
      var jsonNews = jsonDecode(document.body!.text);
      print(jsonNews.runtimeType);

      for (var i = 0; i < 99; i++) {
        titles.add(
            jsonNews['data']['results']['data'][i]['link']['title'].trim());
        imagePaths.add(imageLink +
            jsonNews['data']['results']['data'][i]['image']['filename']);
        descriptions.add(jsonNews['data']['results']['data'][i]['description']);
        links.add(
            domain + jsonNews['data']['results']['data'][i]['link']['link']);

        _news[i] = {
          'titles': titles[i],
          'imagePaths': imagePaths[i],
          'descriptions': descriptions[i],
          'links': links[i]
        };
      }

      return _news;
      notifyListeners();

      isLoaded = true;
      return jsonNews;
    }
  }
}
