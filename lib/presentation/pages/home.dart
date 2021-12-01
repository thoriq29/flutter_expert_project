import 'package:about/about_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_home_page.dart';
import 'package:ditonton/presentation/bloc/system/system_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:movie/presentation/pages/movies_page.dart';
import 'package:tv/presentation/page/search_page.dart';
import 'package:tv/presentation/page/tv_series_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<SystemBloc>(context, listen: false)
        ..add(SetActiveMenu(MenuState.Movie));
     
    });
  }

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
    return BlocBuilder<SystemBloc, SystemState>(
       builder: (context, state) {
         if(state is SelectedMenuState) {
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
                    selected: state.menuState == MenuState.Movie,
                    selectedTileColor: Colors.grey,
                    leading: Icon(Icons.movie),
                    title: Text('Movies'),
                    onTap: () {
                      context.read<SystemBloc>().add(SetActiveMenu(MenuState.Movie));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    selected: state.menuState == MenuState.Tv,
                    selectedTileColor: Colors.grey,
                    leading: Icon(Icons.tv),
                    title: Text('Tv Series'),
                    onTap: () {
                      context.read<SystemBloc>().add(SetActiveMenu(MenuState.Tv));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    selected: state.menuState == MenuState.WatchList ,
                    selectedTileColor: Colors.grey,
                    leading: Icon(Icons.save_alt),
                    title: Text('Watchlist'),
                    onTap: () {
                      context.read<SystemBloc>().add(SetActiveMenu(MenuState.WatchList));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    selected: state.menuState == MenuState.About,
                    selectedTileColor: Colors.grey,
                    onTap: () {
                      context.read<SystemBloc>().add(SetActiveMenu(MenuState.About));
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.info_outline),
                    title: Text('About'),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(_getTitle(state.menuState)),
              actions: _buildAppbarAction(state.menuState)
            ),
            body: _buildBody(state.menuState),
          );
        }
        return Container();
      },
    );
  }
}