import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvSeasonEpisodes {
  final TvRepository repository;

  GetTvSeasonEpisodes(this.repository);

  Future<Either<Failure, Season>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonEpisodes(id, seasonNumber);
  }
}
