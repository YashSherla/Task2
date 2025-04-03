import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:task2/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  final String apiKey = "4931ba855cb141c7ae7cc4a0bc4df6d8";
  Future<List<Article>> getTopHeadlinesCategory(
      String category, int page, String search) async {
    final url =
        'https://newsapi.org/v2/top-headlines?category=$category&page=$page&pageSize=10&q=$search&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log(response.body);
      List articlesJson = json.decode(response.body)['articles'];
      return articlesJson.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<Article>> getTopHeadlines(String country) async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List articlesJson = json.decode(response.body)['articles'];
      return articlesJson.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  ThemeMode _theme = ThemeMode.light;
  ThemeMode get theme => _theme;
  void toggleTheme() {
    _isDark = !_isDark;
    _theme = _isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
