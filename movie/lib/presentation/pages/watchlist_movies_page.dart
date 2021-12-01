import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/router_observer.dart';
import 'package:movie/presentation/bloc/detail/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/card/tv_movie_card.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';
  final Function emptyAction;
  WatchlistMoviesPage(this.emptyAction);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false).add(FetchWatchlistMovie()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserverMovie.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false).add(FetchWatchlistMovie()));
  }

  @override
  void dispose() {
    routeObserverMovie.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieLoaded) {
                if(state.result.length == 0) {
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Belum ada data"),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.emptyAction();
                            },
                            child: const Text('Tambah'),
                            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                          ),
                        )
                      ],
                    ),
                  );
                }
               return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            }
            else if(state is WatchlistMovieError) {
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
