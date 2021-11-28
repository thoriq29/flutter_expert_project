import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/system/system_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/page/watchlist_tv_page.dart';

class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void actionRedirectMovieWatchlist() {
    BlocProvider.of<SystemBloc>(context, listen: false)
        ..add(SetActiveMenu(MenuState.Movie));
  }

  void actionRedirectTvWatchlist() {
    BlocProvider.of<SystemBloc>(context, listen: false)
        ..add(SetActiveMenu(MenuState.Tv));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Movies',
                ),
                Tab(
                  text: 'Tv Series',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WatchlistMoviesPage(
                    actionRedirectMovieWatchlist
                  ),
                  WatchlistTvSeriesPage(
                    actionRedirectTvWatchlist
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}