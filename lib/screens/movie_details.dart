import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routName = 'movie-details';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final mo = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('asd'),
        ),
        body: FutureBuilder(
          future: mo.movieDetailsData(id),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 400,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w780/${mo.defaulMovieDetails['posterPath']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(mo.defaulMovieDetails['overview']),
                      ],
                    ),
        ));
  }
}
