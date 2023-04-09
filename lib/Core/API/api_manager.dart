import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Core/API/models/NewsResponse.dart';
import 'package:news/Core/API/models/SourcesResponse.dart';

class APIManager{
  static const String baseURL = 'newsapi.org';
  // static const String apiKey = 'd90a543924904678a8591ea488728c4c';
  static const String apiKey = '570eebebeb244e23afe9778837a98326';
  static Future<SourcesResponse> getSources(String categoryId)async{
    var url = Uri.https(baseURL,'/v2/top-headlines/sources', {
      'apiKey':apiKey,
      'category':categoryId
    });
    var response = await http.get(url);
    // var sourceString = response.body;
    // var json = jsonDecode(sourceString);
    return SourcesResponse.fromJson(jsonDecode(response.body));
  }
  static Future<NewsResponse> getNews({String? sourceId, String? query})async{
    //?apiKey=d90a543924904678a8591ea488728c4c&sources=bbc-sport
    var url = Uri.http(baseURL,'/v2/everything', {
      'apiKey':apiKey,
      'sources':sourceId,
      'q': query
    });
    var response = await http.get(url);
    return NewsResponse.fromJson(jsonDecode(response.body));
  }
}