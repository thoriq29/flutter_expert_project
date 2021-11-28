import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
