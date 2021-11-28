import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/widget/card/tv_movie_card.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       BlocProvider.of<TopRatedTvBloc>(context).add(TopRatedTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TvSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            }
            else if(state is TopRatedTvError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}
