import 'package:dartz/dartz.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class SaveWatchlist {
  final TvRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
