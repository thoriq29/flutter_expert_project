import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';

class EpisodeModel extends Equatable{
    EpisodeModel({
      required this.airDate,
      required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.productionCode,
      required this.seasonNumber,
      required this.stillPath,
      required this.voteAverage,
      required this.voteCount,
    });

    final DateTime? airDate;
    final int? episodeNumber;
    final int id;
    final String? name;
    final String? overview;
    final String? productionCode;
    final int seasonNumber;
    final String? stillPath;
    final double? voteAverage;
    final int? voteCount;

    Episode toEntity() => 
      Episode(
          airDate: airDate ?? this.airDate,
          episodeNumber: episodeNumber ?? this.episodeNumber,
          id: this.id,
          name: name ?? this.name,
          overview: overview ?? this.overview,
          productionCode: productionCode ?? this.productionCode,
          seasonNumber: this.seasonNumber,
          stillPath: stillPath ?? this.stillPath,
          voteAverage: voteAverage ?? this.voteAverage,
          voteCount: voteCount ?? this.voteCount,
      );

    factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"] == null || json['air_date'] == "" ? null : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"] == null ? null : json["episode_number"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        overview: json["overview"] == null ? null : json["overview"],
        productionCode: json["production_code"] == null ? null : json["production_code"],
        seasonNumber: json["season_number"] == null ? null : json["season_number"],
        stillPath: json["still_path"] == null ? null : json["still_path"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
    );

    Map<String, dynamic> toMap() => {
        "air_date": airDate == null ? null : "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber == null ? null : episodeNumber,
        "id": id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "production_code": productionCode == null ? null : productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath == null ? null : stillPath,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
    };

  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    id,
    name,
    overview,
    productionCode,
    seasonNumber,
    stillPath,
    voteAverage,
    voteCount,
  ];
}
