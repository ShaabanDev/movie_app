import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/models/popular_movie.dart';

class MoviesProvider with ChangeNotifier {
  final String apiKey = 'd4daf067d75d050dae738b474de7b423';
  final String baseUrl = 'https://api.themoviedb.org';
  List<PopularMovie> _popularMovies = [];
  List<MovieDetails> _movieDetails = [];
  Map<String, List<String>> movieImageMap = {};
  List<PopularMovie> get movies {
    return _popularMovies;
  }

  List<MovieDetails> get movieDetialsList {
    return _movieDetails;
  }

  Future<void> fetchMovies() async {
    var url = Uri.parse(
        '$baseUrl/3/movie/popular?api_key=$apiKey&language=en-US&page=1');
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

  bool findDetailsById(String id) {
    return _movieDetails.any((element) => element.id == id);
  }

  late MovieDetails movieDetailsItem;

  Future<void> movieDetailsData(String movieId) async {
    if (findDetailsById(movieId)) {
      await getMovieImages(movieId);
      movieDetailsItem =
          _movieDetails.firstWhere((element) => element.id == movieId);
      return;
    }
    await getMovieImages(movieId);
    var url =
        Uri.parse('$baseUrl/3/movie/$movieId?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    final movieDetails = json.decode(response.body) as Map<String, dynamic>;
    _movieDetails.add(MovieDetails(
        id: movieDetails['id'].toString(),
        title: movieDetails['title'],
        posterPath: movieDetails['poster_path'],
        releaseDate: movieDetails['release_date'],
        overview: movieDetails['overview'],
        voteAverage: movieDetails['vote_average'],
        status: movieDetails['status']));
    movieDetailsItem = _movieDetails[_movieDetails.length - 1];
    notifyListeners();
  }

  List<String> movieImageList = [];

  Future<void> getMovieImages(String movieId) async {
    var url = Uri.parse(
        '$baseUrl/3/movie/$movieId/images?api_key=$apiKey&language=null');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final imagesData = json.decode(response.body) as Map<String, dynamic>;
      final list1 = imagesData['posters'];
      final list2 = imagesData['backdrops'];
      movieImageList.clear();
      list1.forEach((element) {
        movieImageList.add(element['file_path']);
      });

      list2.forEach((element) {
        movieImageList.add(element['file_path']);
      });
    }
  }
}
