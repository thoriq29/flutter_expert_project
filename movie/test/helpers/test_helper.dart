import 'package:movie/data/datasource/database_helper.dart';
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/data/datasource/watchlist_data_source.dart';

import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieWatchListDataSource,
  MovieDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
