import 'package:flutter/material.dart';
import 'package:tv/common/config.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/page/tv_detail_page.dart';
import 'package:tv/presentation/widget/card/movie_poster_card.dart';

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
