import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routName = 'movie-details';
  @override
  Widget build(BuildContext context) {
    print('rebuilding...');
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final mo = Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie details"),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: mo.movieDetailsData(id),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 400,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w780/${mo.movieDetailsItem.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]),
                          Text(mo.movieDetailsItem.overview),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            //   scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (ctx, i) => mo.movieImageList.isEmpty
                                ? SizedBox(
                                    height: 10,
                                  )
                                : Container(
                                    height: 300,
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w780/${mo.movieImageList[i]}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          )
                        ],
                      ),
          ),
        ));
  }
}

/*  */