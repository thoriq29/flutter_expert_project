import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetWatchlistTvSeries {
  final TvRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
