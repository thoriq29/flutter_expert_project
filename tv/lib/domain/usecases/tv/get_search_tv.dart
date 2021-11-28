import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class SearchTV {
  final TvRepository repository;

  SearchTV(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
