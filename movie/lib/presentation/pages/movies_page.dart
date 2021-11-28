import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/styles.dart';
import 'package:movie/presentation/bloc/list/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/list/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/list/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/widgets/list/movie_list.dart';
import 'package:movie/presentation/widgets/sub_header.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context).add(NowPlayingMoviesEvent());
      BlocProvider.of<PopularMoviesBloc>(context).add(PopularMoviesEvent());
      BlocProvider.of<TopRatedMoviesBloc>(context).add(TopRatedMoviesEvent());
    });
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
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesLoaded) {
                    return MovieList(state.result);
                  }
                  else if(state is NowPlayingMoviesError) {
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
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
             BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesLoaded) {
                    return MovieList(state.result);
                  }
                  else if(state is PopularMoviesError) {
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
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
               BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesLoaded) {
                    return MovieList(state.result);
                  }
                  else if(state is TopRatedMoviesError) {
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
