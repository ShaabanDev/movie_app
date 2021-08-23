import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/popular_movie.dart';

class MoviesProvider with ChangeNotifier {
  List<PopularMovie> _popularMovies = [];

  List<PopularMovie> get movies {
    return _popularMovies;
  }

  Future<void> fetchMovies() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=d4daf067d75d050dae738b474de7b423&language=en-US&page=1');
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final results = responseData['results'];
    results.forEach((element) {
      _popularMovies.add(PopularMovie(
        id: element['id'].toString(),
        posterPath: element['poster_path'],
      ));
    });
    notifyListeners();
  }

  PopularMovie findeById(String id) {
    final PopularMovie move =
        _popularMovies.firstWhere((element) => element.id == id);
    return move;
  }

  Map<String, dynamic> defaulMovieDetails = {};

  /* MovieDetails(
        id: movieDetails['id'],
        title: movieDetails['title'],
        posterPath: movieDetails['poster_path'],
        releaseDate: movieDetails['release_date'],
        overview: movieDetails['overview'],
        voteAverage: movieDetails['vote_average'],
        status: movieDetails['status']);
 */
  Future<void> movieDetailsData(String movieId) async {
    if (movieId == defaulMovieDetails['id']) return;
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=d4daf067d75d050dae738b474de7b423&language=en-US');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      defaulMovieDetails = {};
      return;
    }
    final movieDetails = json.decode(response.body) as Map<String, dynamic>;
    defaulMovieDetails = {
      'id': movieDetails['id'],
      'title': movieDetails['title'],
      'posterPath': movieDetails['poster_path'],
      'releaseDate': movieDetails['release_date'],
      'overview': movieDetails['overview'],
      'voteAverage': movieDetails['vote_average'],
      'status': movieDetails['status']
    };
    notifyListeners();
  }
}
