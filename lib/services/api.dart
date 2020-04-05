import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/models/movie_model.dart';
import 'package:moofies/models/search_model.dart';

class Api {
  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "488b24a89214f602dec537c161df5303";

  Future<List<GenreModel>> getGenreList() async {
    final response = await http.get('$url/genre/movie/list?api_key=$apiKey');

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['genres'].cast<Map<String, dynamic>>();

      return parsed
          .map<GenreModel>((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

   Future<List<SearchModel>> serach(String searchTerm) async {
    final response = await http.get('$url/search/movie?api_key=$apiKey&language=en-US&query=$searchTerm&page=1&include_adult=false');

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      return parsed
          .map<SearchModel>((json) => SearchModel.fromJson(json))
          .toList();
         
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<FeaturedMovieModel>> getFeaturedMovies() async {
    final response = await http.get('$url/trending/movie/day?api_key=$apiKey');

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      return parsed
          .map<FeaturedMovieModel>((json) => FeaturedMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    final response = await http.get("$url/movie/$movieId?api_key=$apiKey");

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }

  Future<MovieModel> getTrailerInfo(int movieId) async {
    final response =
        await http.get("$url/movie/$movieId/videos?api_key=$apiKey");

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }

  String getPosterImage(String input) {
    return "https://image.tmdb.org/t/p/w500/$input";
  }

  String getPosterImageOriginal(String input) {
    return "https://image.tmdb.org/t/p/original/$input";
  }
}
