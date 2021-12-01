import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/common/router_observer.dart';
import 'package:tv/presentation/bloc/watchlist_tv_page_bloc.dart';
import 'package:tv/presentation/widget/card/tv_movie_card.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';
  final Function emptyAction;
  WatchlistTvSeriesPage(this.emptyAction);
  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvSeriesPage> with RouteAware {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TvWatchlistPageBloc>(context, listen: false).add(FetchWatchlistTvSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserverTv.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<TvWatchlistPageBloc>(context, listen: false).add(FetchWatchlistTvSeries());
  }

  @override
  void dispose() {
    routeObserverTv.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistPageBloc, WatchlistPageState>(
          builder: (context, state) {
            if (state is WatchlistPageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistPageLoaded) {
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
                  return TvCard(movie);
                },
                itemCount: state.result.length,
              );
            }
            else if(state is WatchlistPageError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          }
        )
      ),
    );
  }
}
