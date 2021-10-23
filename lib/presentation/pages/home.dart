import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/tv/search_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_home_page.dart';
import 'package:ditonton/presentation/provider/system_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_page.dart';
import 'movie/movies_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> _buildAppbarAction(MenuState _state) {
    switch (_state) {
      case MenuState.Movie:
        return [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ];
      case MenuState.Tv:
        return [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ];
      case MenuState.WatchList:
      default:
        return [];
    }
  }

  Widget _buildBody(MenuState _state) {
    switch (_state) {
      case MenuState.Movie:
        return HomeMoviePage();
      case MenuState.Tv:
        return TvSeriesPage();
      case MenuState.WatchList:
        return WatchListPage();
      default:
        return AboutPage();
    }
  }

  String _getTitle(MenuState _state) {
    switch (_state) {
      case MenuState.Movie:
        return "Movies";
      case MenuState.Tv:
        return "Tv Series";
      case MenuState.WatchList:
        return "Watch List";
      default:
        return "About";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemNotifier>(builder: (context, data, child) {
      return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/circle-g.png'),
                  ),
                  accountName: Text('Ditonton'),
                  accountEmail: Text('ditonton@dicoding.com'),
                ),
                ListTile(
                  selected: data.menuState == MenuState.Movie,
                  selectedTileColor: Colors.grey,
                  leading: Icon(Icons.movie),
                  title: Text('Movies'),
                  onTap: () {
                    data.setMenuState(MenuState.Movie);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  selected: data.menuState == MenuState.Tv,
                  selectedTileColor: Colors.grey,
                  leading: Icon(Icons.tv),
                  title: Text('Tv Series'),
                  onTap: () {
                    data.setMenuState(MenuState.Tv);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  selected: data.menuState == MenuState.WatchList,
                  selectedTileColor: Colors.grey,
                  leading: Icon(Icons.save_alt),
                  title: Text('Watchlist'),
                  onTap: () {
                    data.setMenuState(MenuState.WatchList);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  selected: data.menuState == MenuState.About,
                  selectedTileColor: Colors.grey,
                  onTap: () {
                    data.setMenuState(MenuState.About);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.info_outline),
                  title: Text('About'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(_getTitle(data.menuState)),
            actions: _buildAppbarAction(data.menuState)
          ),
          body: _buildBody(data.menuState),
        );
      },
    );
  }
}