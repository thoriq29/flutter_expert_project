import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
