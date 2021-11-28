import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/common/styles.dart';
import 'package:tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:tv/presentation/widget/card/tv_movie_card.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search/tv';

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
                 BlocProvider.of<SearchTvBloc>(context, listen: false).add(FetchSearchTv(query));
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
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvLoaded) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                }
                else if(state is SearchTvError) {
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
    );
  }
}
