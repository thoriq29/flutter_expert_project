import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/widget/card/tv_movie_card.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       BlocProvider.of<PopularTvBloc>(context).add(PopularTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TvCard(tv);
                },
                itemCount: state.tv.length,
              );
            }
            else if(state is PopularTvError) {
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
