//Provedor de Información.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
//La clase provider extiende de change Notifier

class MovieProvider extends ChangeNotifier {
  String _apiKey = '1ea3a694487849b76e34609ebf654675';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-US';

  List<Movie> onDisplayMovies = [];

  MovieProvider() {
    print("MovieProvider inicializado");

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    this.onDisplayMovies = nowPlayingResponse.results;

    //Notifica a los widgets
    notifyListeners();
  }
}
