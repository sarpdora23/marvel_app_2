import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class MarvelAPI {
  final String BASE_URL = "https://gateway.marvel.com/v1/public/";
  final String PUBLIC_API_KEY = "cb1c7120a276134ac1e34ce1651747b6";
  final String PRIVATE_API_KEY = "3c911b59f69dffc6aca50276de4a2a97963b3e57";
  Future<http.Response> fetchComics() {
    return http.get(Uri.parse(createUrl("comics?")));
  }

  Future<http.Response> fetchCharacters() {
    return http.get(Uri.parse(createUrl("characters?")));
  }

  String createUrl(String header) {
    String url = BASE_URL;
    String ts = createTS();
    String query1 = "ts=$ts";
    String query2 = "&apikey=$PUBLIC_API_KEY";
    var bytes = utf8.encode("$ts$PRIVATE_API_KEY$PUBLIC_API_KEY");
    var hash = md5.convert(bytes);
    String query3 = "&hash=$hash";
    url = url + header + query1 + query2 + query3;
    print(url);
    return url;
  }

  String createTS() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('y-M-d H:m:s');
    final String formatted = formatter.format(now);
    print(formatted);
    return formatted;
  }
}
