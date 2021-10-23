import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/card/movie_poster_card.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MoviePosterCard(
            imagePath: '$BASE_IMAGE_URL${movie.posterPath}', 
            onTap: () {
              Navigator.pushNamed(
                context,
                MovieDetailPage.ROUTE_NAME,
                arguments: movie.id,
              );
            },
            index: index,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
