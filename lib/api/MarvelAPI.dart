

import 'package:flutter/material.dart';
import 'package:marvel_app_2/api/models/Comic.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
class MarvelAPI{
  final String BASE_URL = "https://gateway.marvel.com/v1/public/";
  final String PUBLIC_API_KEY = "cb1c7120a276134ac1e34ce1651747b6";
  final String PRIVATE_API_KEY = "3c911b59f69dffc6aca50276de4a2a97963b3e57";

  Future<List<Comic>> fetchComicsByNumber(int count){
    String query = "limit=$count";
    return _fetchComics(createUrl("comics?",query));
  }
  Future<List<Comic>> fetchComicsByStartTitle(String startTitle) async{
    String query = "titleStartsWith=$startTitle";
     return _fetchComics(createUrl("comics?", query));
  }
  Future<List<Comic>> fetchComicById(String id) async{
     return _fetchComics(createUrl("comics?","",true,id));
  }

  Future<List<Comic>> _fetchComics(String url) async{
    List<Comic> comics = List.empty(growable: true);
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(response.body);
      for(int i = 0; i<json['data']['results'].length;i++){
        String title;
        String description;
        String image;
        String id;
        String character_url;
        id = json['data']['results'][i]['id'].toString();
        if(json['data']['results'][i]['title'] == null){
          title = "No Title";
        }
        else{
          title = json['data']['results'][i]['title'];
        }
        //print("Response: $title");
        if(json['data']['results'][i]['description'] == null){
          description = "No description";
        }
        else{
          description = json['data']['results'][i]['description'];
        }
        image = json['data']['results'][i]['thumbnail']['path'];
        image = image + json['data']['results'][i]['thumbnail']['extension'];
        character_url = json['data']['results'][i]['characters']['collectionURI'];
        var newCom = Comic(id,title,description,image,character_url);
        comics.add(newCom);
        print(newCom.title);
      }
      return comics;
    }
    else{
      throw Exception('Failed to load album');
      return comics;
    }
  }
  String createUrl(String header,String extra_quey,[bool isone = false,String id= "0"]){
    String url = BASE_URL;
    String ts = createTS();
    String query1 = "ts=$ts";
    String query2 = "&apikey=$PUBLIC_API_KEY";
    var bytes = utf8.encode("$ts$PRIVATE_API_KEY$PUBLIC_API_KEY");
    var hash = md5.convert(bytes);
    String query3 = "&hash=$hash";
    if(isone){
      url = url+"comics/"+id+"?"+"&"+query1+query2+query3;
    }
    else{
      url = url+header+query1+"&"+extra_quey+query2+query3;
    }
    print(url);
    return url;
  }
  String createTS(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('y-M-dH:m:s');
    final String formatted = formatter.format(now);
    print(formatted);
    return formatted;
  }
  Future<List<Character>> _fetchCharacters(String url) async{
      List<Character> character_list = [Character()];
      final response =  await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        Map<String,dynamic> json = jsonDecode(response.body);
        for(int i = 0; i<json['data']['results'].length;i++){
          String name;
          String description;
          String image;
          String id;
          id = json['data']['results'][i]['id'].toString();
          if(json['data']['results'][i]['name'] == null){
            name = "No Title";
          }
          else{
            name = json['data']['results'][i]['name'];
          }
          if(json['data']['results'][i]['description'] == null){
            description = "No description";
          }
          else{
            description = json['data']['results'][i]['description'];
          }
          image = json['data']['results'][i]['thumbnail']['path'];
          image = image + json['data']['results'][i]['thumbnail']['extension'];
          List<String> comics_list = [""];
          for(int j = 0; j<json['data']['results'][i]['comics']['items'].length;j++){
            comics_list.add(json['data']['results'][i]['comics']['items'][j]['resourceURI']);
          }
          var newChar = Character();
          newChar.name = name;
          newChar.comic_list = comics_list;
          newChar.image = image;
          newChar.description = description;
          newChar.id = id;
          character_list.add(newChar);
          print(newChar.name);
        }
        return character_list;
      }
      else{
        throw Exception("Error");
      }
  }
  Future<List<Character>> fetchCharactersByNumber(int num){
    String query = "limit=${num.toString()}";
    return _fetchCharacters(createUrl("characters?", query));
  }
}
