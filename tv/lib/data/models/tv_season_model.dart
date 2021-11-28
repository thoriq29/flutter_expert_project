import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season.dart';
import 'dart:convert';

import 'episode_model.dart';

SeasonModel seasonModelFromMap(String str) => SeasonModel.fromJson(json.decode(str));

String seasonModelToMap(SeasonModel data) => json.encode(data.toMap());

class SeasonModel extends Equatable {
    SeasonModel({
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
    final List<EpisodeModel>? episodes;
    final String? name;
    final String? overview;
    final int? seasonModelId;
    final String? posterPath;
    final int seasonNumber;

    Season toEntity() => 
      Season(
          id: id ?? this.id,
          airDate: this.airDate,
          episodes: this.episodes?.map((episode) => episode.toEntity()).toList(),
          name: name ?? this.name,
          overview: overview ?? this.overview,
          seasonModelId: seasonModelId ?? this.seasonModelId,
          posterPath: posterPath ?? this.posterPath,
          seasonNumber: this.seasonNumber,
      );

    factory SeasonModel.fromJson(Map<String, dynamic> json) { 
      return SeasonModel(
        id: json["_id"] == null ? null : json["_id"].toString(),
        airDate: json["air_date"] == null ||  json["air_date"] == "" ? null : DateTime.parse(json["air_date"]),
        episodes: json["episodes"] == null ? null : List<EpisodeModel>.from(json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        overview: json["overview"] == null ? null : json["overview"],
        seasonModelId: json["id"] == null ? null : json["id"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        seasonNumber: json["season_number"] == null ? null : json["season_number"],
    );}

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "air_date": airDate == null ? null : "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episodes": episodes == null ? null : List<dynamic>.from(episodes!.map((x) => x.toMap())),
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "id": seasonModelId == null ? null : seasonModelId,
        "poster_path": posterPath == null ? null : posterPath,
        "season_number":  seasonNumber,
    };

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
