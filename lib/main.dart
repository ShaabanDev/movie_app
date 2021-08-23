import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:movie_app/screens/movie_details.dart';
import 'package:provider/provider.dart';
import '../screens/movies_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MoviesProvider()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MoviesOverViewScreen(),
        routes: {
          MovieDetailsScreen.routName: (_) => MovieDetailsScreen(),
        },
      ),
    );
  }
}
