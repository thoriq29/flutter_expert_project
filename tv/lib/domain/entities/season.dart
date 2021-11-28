import 'package:equatable/equatable.dart';

import 'episode.dart';

class Season extends Equatable {
  Season({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? id;
  final DateTime? airDate;
  final List<Episode>? episodes;
  final String? name;
  final String? overview;
  final int? seasonModelId;
  final String? posterPath;
  final int? seasonNumber;

  @override
  List<Object?> get props => [
    id,
    airDate,
    episodes,
    name,
    overview,
    seasonModelId,
    posterPath,
    seasonNumber,
  ];
}