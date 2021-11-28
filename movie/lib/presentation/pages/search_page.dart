import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/styles.dart';
import 'package:movie/presentation/bloc/search/search_movie_bloc.dart';
import 'package:movie/presentation/widgets/card/tv_movie_card.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                BlocProvider.of<SearchMovieBloc>(context).add(FetchSearchMovie(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchMovieEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text("Data Kosong"),
                    ),
                  );
                }
                else if (state is SearchMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMovieLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.result.length,
                    ),
                  );
                }
                else if(state is SearchMovieError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                return Container();
              }
            ),
          ],
        ),
      ),
    );
  }
}
