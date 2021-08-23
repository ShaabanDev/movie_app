import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:movie_app/screens/movie_details.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatelessWidget {
  final String movieId;

  MovieItem(this.movieId);
  @override
  Widget build(BuildContext context) {
    final movie =
        Provider.of<MoviesProvider>(context, listen: false).findeById(movieId);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MovieDetailsScreen.routName, arguments: movieId);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 300,
              child: Image(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w780/${movie.posterPath}',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
