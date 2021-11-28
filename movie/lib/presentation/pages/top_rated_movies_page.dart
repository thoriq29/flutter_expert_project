import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/list/top_rated_movies_bloc.dart';
import 'package:movie/presentation/widgets/card/tv_movie_card.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       BlocProvider.of<TopRatedMoviesBloc>(context).add(TopRatedMoviesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesLoaded) {
               return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            }
            else if(state is TopRatedMoviesError) {
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
