import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
