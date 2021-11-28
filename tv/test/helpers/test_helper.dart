import 'package:tv/data/datasources/database_helper.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/datasources/watchlist_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv/domain/repository/tv_repository.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvWatchListDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}