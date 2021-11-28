import 'package:tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
        required this.backdropPath,
        required this.firstAirDate,
        required this.genreIds,
        required this.id,
        required this.name,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.voteAverage,
        required this.voteCount,
    });

    final String? backdropPath;
    final String firstAirDate;
    final List<int> genreIds;
    final int id;
    final String name;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String? posterPath;
    final double voteAverage;
    final int voteCount;

    factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      firstAirDate: json["first_air_date"] != null ? json["first_air_date"]:"-",
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"], 
      name: json["name"], 
      originalLanguage: json["original_language"], 
      originalName: json["original_name"], 
      originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
      "backdrop_path": backdropPath,
      "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
      "id": id,
      "overview": overview,
      'first_air_date': firstAirDate,
      "popularity": popularity,
      "poster_path": posterPath,
      "vote_average": voteAverage,
      "vote_count": voteCount,
      'name': name,
      'origin_country': List<dynamic>.from(originCountry.map((x) => x)),
      'original_language': originalLanguage,
      'original_name': originalName,
    };

    Tv toEntity() {
      return Tv(
        backdropPath: this.backdropPath,
        genreIds: this.genreIds,
        id: this.id,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
        firstAirDate: this.firstAirDate, 
        name: this.name, 
        originalLanguage: this.originalLanguage,
        originalName: this.originalName, 
        originCountry: this.originCountry
      );
    }

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genreIds,
    id,
    name,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount
  ];
}
