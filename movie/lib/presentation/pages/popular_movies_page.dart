import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/list/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/card/tv_movie_card.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       BlocProvider.of<PopularMoviesBloc>(context).add(PopularMoviesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesLoaded) {
               return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            }
            else if(state is PopularMoviesError) {
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
