import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;

  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, Season>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
