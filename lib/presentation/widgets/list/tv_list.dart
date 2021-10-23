import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/widgets/card/movie_poster_card.dart';
import 'package:flutter/material.dart';

class TvSeriesList extends StatelessWidget {
  final List<Tv> tvSeries;
  final bool? showRank;

  TvSeriesList({required this.tvSeries, this.showRank});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return MoviePosterCard(
            imagePath: '$BASE_IMAGE_URL${tv.posterPath}', 
            onTap: () {
              Navigator.pushNamed(
                context,
                TvDetailPage.ROUTE_NAME,
                arguments: tv.id,
              );
            },
            index: index,
            showRank: showRank,
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
