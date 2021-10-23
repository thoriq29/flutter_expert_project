import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TvCard extends StatelessWidget {
  final Tv tv;

  TvCard(this.tv);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      id: tv.id, 
      name: tv.name, 
      overview: tv.overview, 
      posterPath: tv.posterPath,
      onTap: () {
        print("Masuk sini");
        Navigator.pushNamed(
          context,
          TvDetailPage.ROUTE_NAME,
          arguments: tv.id,
        ).then((value) => Future.microtask(() =>
          Provider.of<WatchlistTvNotifier>(context, listen: false)
              .fetchWatchlistTvSeries()
        ));
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      id: movie.id, 
      name: movie.title, 
      overview: movie.overview, 
      posterPath: movie.posterPath,
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetailPage.ROUTE_NAME,
          arguments: movie.id,
        ).then((value) => Future.microtask(() =>
          Provider.of<WatchlistMovieNotifier>(context, listen: false)
              .fetchWatchlistMovies()
        ));
      },
    );
  }
}


class CardWidget extends StatelessWidget {

  final String? name;
  final int? id;
  final String? overview;
  final String? posterPath;
  final Function()? onTap;

  CardWidget({  this.id,  this.name,  this.overview,  this.posterPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL$posterPath',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}