import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class RemoveWatchlist {
  final TvRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
