import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
