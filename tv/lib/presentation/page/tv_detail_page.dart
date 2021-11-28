import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/common/color.dart';
import 'package:tv/common/config.dart';
import 'package:tv/common/styles.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/detail/tv_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_data_bloc.dart';
import 'package:tv/presentation/widget/card/tv_episode_card.dart';
import 'package:tv/presentation/widget/dropdown_season.dart';

class TvDetailPage extends StatefulWidget {
  
  static const ROUTE_NAME = 'tv/detail';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(context, listen: false)
      ..add(GetTvDetailData(widget.id));
    }).then((value) {
      BlocProvider.of<WatchlistTvBloc>(context, listen: false)
      ..add(LoadWatchListStatus(widget.id));
      BlocProvider.of<TvRecommendationBloc>(context, listen: false)
        ..add(FetchTvRecommendation(widget.id));
         var state = BlocProvider.of<TvDetailBloc>(context, listen: false).state;
      BlocProvider.of<TvSeasonBloc>(context, listen: false)
        ..add(GetTvSeasonData(widget.id, state is TvDetailLoaded ? state.result.seasons.length > 0 ? state.result.seasons[0].seasonNumber : 1 : 1)); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
       builder: (context, state) {
         if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            final tv = state.result;
            TvRecommendationState recommendationState =
              context.watch<TvRecommendationBloc>().state;
             bool isAddedToWatchList = context.select<WatchlistTvBloc, bool>(
              (watchlistBloc) => (watchlistBloc.state is WatchlistTvStatus)
                  ? (watchlistBloc.state as WatchlistTvStatus).result
                  : false);
            return SafeArea(
              child: DetailContent(
                tv,
                recommendationState is TvRecommendationLoaded
                    ? recommendationState.tvs
                    : List.empty(),
                isAddedToWatchList,
              ),
            );
          }
          else if(state is TvDetailError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
       }
      )
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  DetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  List<Widget> seasons(Season seasonEpisodes) {
    return seasonEpisodes.episodes!.map((episode) => TvEpisodeCard(
      episodeName: episode.name,
      overview: episode.overview,
      posterPath: episode.stillPath,
      episodeNumber: episode.episodeNumber.toString()
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context.read<WatchlistTvBloc>().add(AddToWatchList(tv));
                                  
                                } else {
                                  context.read<WatchlistTvBloc>().add(RemoveWatchList(tv));
                                }

                                final message = context.select<
                                    WatchlistTvBloc,
                                    String>((bloc) => (bloc.state
                                        is WatchlistTvStatus)
                                    ? (bloc.state as WatchlistTvStatus)
                                                .result ==
                                            false
                                        ? watchlistAddSuccessMessage
                                        : watchlistRemoveSuccessMessage
                                    : '');


                                if (message ==
                                        watchlistAddSuccessMessage ||
                                    message ==
                                        watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            recommendations.length != 0 ?
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ) : Container(),
                            recommendations.length != 0 ?
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tv = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.ROUTE_NAME,
                                          arguments: tv.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '$BASE_IMAGE_URL${tv.posterPath}',
                                          placeholder: (context, url) =>
                                              Center(
                                            child:
                                                CircularProgressIndicator(),
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ) :  Container(),
                            SizedBox(height: 16),
                            tv.seasons.length == 1 ?
                            Text(
                              tv.seasons.first.name ?? "-",
                              style: kHeading6,
                            ):
                            DropdownSeason(
                              selectedSeason: context.select<TvSeasonBloc, int>((bloc) => (bloc.state
                                        is TvSeasonLoaded) ? (bloc.state as TvSeasonLoaded).selectedSeasonID : tv.seasons.length > 0 ? tv.seasons[0].seasonNumber : 1),
                              seasons: tv.seasons, 
                              onSelected: (val) {
                                int selectedSeasonID =  context.select<TvSeasonBloc, int>((bloc) => (bloc.state
                                        is TvSeasonLoaded) ? (bloc.state as TvSeasonLoaded).selectedSeasonID : tv.seasons.length > 0 ? tv.seasons[0].seasonNumber : 1);
                                if(val != selectedSeasonID) {
                                  Provider.of<TvSeasonBloc>(context, 
                                            listen: false)
                                          .add(GetTvSeasonData(tv.id, val));
                                }
                              }
                            ),
                            BlocBuilder<TvSeasonBloc, TvSeasonState>(
                              builder: (context, state) {
                                if(state is TvSeasonLoading) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (state is TvSeasonLoaded) {
                                  final seasonEpisodes = state.result;
                                  if(seasonEpisodes.episodes?.length == 0) {
                                    return Container();
                                  }
                                  return Column(
                                    children: seasons(seasonEpisodes),
                                  );
                                } else if(state is TvSeasonError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                else {
                                  return Container();
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            initialChildSize: 0.40,
            minChildSize: 0.30,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

}
