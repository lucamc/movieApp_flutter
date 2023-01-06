//Provedor de Información.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/popular_response.dart';

import '../models/models.dart';
//La clase provider extiende de change Notifier

class MovieProvider extends ChangeNotifier {
  String _apiKey = '1ea3a694487849b76e34609ebf654675';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-US';

  //CardSwiper Movies
  List<Movie> onDisplayMovies = [];

  //Movie Slider popular Movies
  List<Movie> onDisplayPopularMovies = [];

  //CreditsCards
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MovieProvider() {
    print("MovieProvider inicializado");

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  //get Movies Home
  getOnDisplayMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    //Notifica a los widgets
    notifyListeners();
  }

  //get Popular Movies
  getPopularMovies() async {
    final jsonData = await this._getJsonData('3/movie/popular', 1);

    final popularResponse = PopularResponse.fromJson(jsonData);

    //Toma peliculas actuales y siempre va ser parte de las mismas popular movies
    this.onDisplayPopularMovies = [
      ...onDisplayPopularMovies,
      ...popularResponse.results
    ];

    //Notifica a los widgets
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('info de los actores');

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    return moviesCast[movieId] = creditsResponse.cast;
  }
}
