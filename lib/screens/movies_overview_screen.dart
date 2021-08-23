import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:movie_app/screens/movie_item.dart';
import 'package:provider/provider.dart';

class MoviesOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mov = Provider.of<MoviesProvider>(context, listen: false);
    print("object....");
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: FutureBuilder(
        future: mov.fetchMovies(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: 4,
                    itemBuilder: (ctx, i) => MovieItem(mov.movies[i].id),
                  ),
      ),
    );
  }
}
