import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:arsivbox/models_json/filmjson.dart';
import 'package:logger/logger.dart';
import 'package:arsivbox/models_json/linkjson.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String _baseUrl;
  static ApiService _instance = ApiService._privateConstructor();

  ApiService._privateConstructor() {
    _baseUrl = "https://arsivbox-5d6a9.firebaseio.com/";
  }

  static ApiService getInstance() {
    if (_instance == null) {
      return ApiService._privateConstructor();
    }
    return _instance;
  }

  Future<List<LinkJson>> getLink() async {
    final response = await http.get("$_baseUrl/posts.json");
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final linkList = LinkedList.fromJsonList(jsonResponse);
        return linkList.links;
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> addLink(LinkJson linkJson) async {
    final jsonBody = json.encode(linkJson.toJson());
    final response = await http.post("$_baseUrl/posts.json", body: jsonBody);
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> removeLink(String key) async {
    final response = await http.delete("$_baseUrl/posts/$key.json");
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<List<FilmJson>> getFilm() async {
    final response = await http.get('$_baseUrl/film.json');
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final filmList = FilmList.fromJsonList(jsonResponse);
        return filmList.films;
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> addFilm(FilmJson filmJson) async {
    final jsonBody = json.encode(filmJson.toJson());
    final response = await http.post('$_baseUrl/film.json', body: jsonBody);
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> removeFilm(String key) async {
    final response = await http.delete('$_baseUrl/film/$key.json');
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }
}
