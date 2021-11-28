import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/common/styles.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/page/popular_tv_page.dart';
import 'package:tv/presentation/page/top_rated_tv_page.dart';
import 'package:tv/presentation/widget/list/tv_list.dart';
import 'package:tv/presentation/widget/sub_header.dart';

class TvSeriesPage extends StatefulWidget {
  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
     BlocProvider.of<NowPlayingTvBloc>(context).add(NowPlayingTvEvent());
      BlocProvider.of<PopularTvBloc>(context).add(PopularTvEvent());
      BlocProvider.of<TopRatedTvBloc>(context).add(TopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              
              ),
              BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                builder: (context, state) {
                  if (state is NowPlayingTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvLoaded) {
                    return TvSeriesList(tvSeries: state.result);
                  }
                  else if(state is NowPlayingTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                }
              ),
              SubHeader(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
                  if (state is PopularTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvLoaded) {
                    return TvSeriesList(tvSeries: state.tv);
                  }
                  else if(state is PopularTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                }
              ),
              SubHeader(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvLoaded) {
                    return TvSeriesList(tvSeries: state.result);
                  }
                  else if(state is TopRatedTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
