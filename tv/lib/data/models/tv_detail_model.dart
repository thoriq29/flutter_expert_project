import 'package:tv/data/models/tv_season_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class TvDetailResponse extends Equatable {
    TvDetailResponse({
        required this.backdropPath,
        required this.createdBy,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.languages,
        required this.lastAirDate,
        required this.lastEpisodeToAir,
        required this.name,
        required this.nextEpisodeToAir,
        required this.networks,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.seasons,
        required this.spokenLanguages,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    final String backdropPath;
    final List<CreatedBy> createdBy;
    final List<int> episodeRunTime;
    final String firstAirDate;
    final List<GenreModel> genres;
    final String homepage;
    final int id;
    final bool inProduction;
    final List<String> languages;
    final String lastAirDate;
    final EpisodeToAir? lastEpisodeToAir;
    final String name;
    final EpisodeToAir? nextEpisodeToAir;
    final List<Network> networks;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final List<Network> productionCompanies;
    final List<ProductionCountry> productionCountries;
    final List<SeasonModel> seasons;
    final List<SpokenLanguage> spokenLanguages;
    final String status;
    final String tagline;
    final String type;
    final double voteAverage;
    final int voteCount;



  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath : json['backdrop_path'] != null ? json['backdrop_path'] : "",
        episodeRunTime : json['episode_run_time'].cast<int>(),
        firstAirDate : json['first_air_date'] != null ? json['first_air_date'] : "",
        homepage : json['homepage'],
        id : json['id'],
        inProduction : json['in_production'],
        languages : json['languages'].cast<String>(),
        lastAirDate : json['last_air_date'],
        lastEpisodeToAir : json['last_episode_to_air'] != null ? EpisodeToAir.fromJson(json['last_episode_to_air']) : null,
        name : json['name'],
        nextEpisodeToAir : json['next_episode_to_air'] != null ? EpisodeToAir.fromJson(json['next_episode_to_air']) : null,
        numberOfEpisodes : json['number_of_episodes'],
        numberOfSeasons : json['number_of_seasons'],
        originCountry : json['origin_country'].cast<String>(),
        originalLanguage : json['original_language'],
        originalName : json['original_name'],
        overview : json['overview'],
        popularity : json['popularity'],
        posterPath : json['poster_path'],
        status : json['status'],
        tagline : json['tagline'],
        type : json['type'],
        voteAverage : json['vote_average'],
        voteCount : json['vote_count'], 
        createdBy: [],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        networks: [], 
        productionCompanies: [], 
        productionCountries: [],
        seasons:  List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))).where((element) => element.posterPath != null).toList(),
        spokenLanguages: [],
      );

  TvDetail toEntity() {
    return TvDetail(
      backdropPath : this.backdropPath,
      episodeRunTime : this.episodeRunTime,
      firstAirDate : this.firstAirDate,
      homepage : this.homepage,
      id : this.id,
      inProduction : this.inProduction,
      languages : this.languages,
      lastAirDate : this.lastAirDate,
      lastEpisodeToAir : this.lastEpisodeToAir,
      name : this.name,
      nextEpisodeToAir : this.nextEpisodeToAir,
      numberOfEpisodes : this.numberOfEpisodes,
      numberOfSeasons : this.numberOfSeasons,
      originCountry : this.originCountry,
      originalLanguage : this.originalLanguage,
      originalName : this.originalName,
      overview : this.overview,
      popularity : this.popularity,
      posterPath : this.posterPath,
      status : this.status,
      tagline : this.tagline,
      type : this.type,
      voteAverage : this.voteAverage,
      voteCount : this.voteCount, 
      createdBy: this.createdBy,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      networks: this.networks, 
      productionCompanies: this.productionCompanies, 
      productionCountries: this.productionCountries,
      seasons: this.seasons,
      spokenLanguages: this.spokenLanguages
    );
  }
  
  @override
  List<Object?> get props => [
    backdropPath,
    createdBy,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    networks,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    seasons,
    spokenLanguages,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}

class CreatedBy extends Equatable {
    CreatedBy({
        required this.id,
        required this.creditId,
        required this.name,
        required this.gender,
        required this.profilePath,
    });

    final int id;
    final String creditId;
    final String name;
    final int gender;
    final String profilePath;

  @override
  List<Object?> get props => [
    id,
    creditId,
    name,
    gender,
    profilePath,
  ];
}

class EpisodeToAir extends Equatable {
    EpisodeToAir({
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

    final String airDate;
    final int episodeNumber;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final dynamic stillPath;
    final double voteAverage;
    final double voteCount;

    factory EpisodeToAir.fromJson(Map<String, dynamic> json) => EpisodeToAir(
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      id : json['id'],
      name: json['name'],
      overview: json['overview'],
      productionCode: json['production_code'],
      seasonNumber: json['season_number'],
      stillPath: json['still_path'],
      voteAverage: double.parse(json['vote_average'].toString()),
      voteCount: double.parse(json['vote_count'].toString())
    );

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
    voteCount
  ];
}

class Network extends Equatable{
    Network({
        required this.name,
        required this.id,
        required this.logoPath,
        required this.originCountry,
    });

    final String name;
    final int id;
    final String logoPath;
    final String originCountry;

  @override
  List<Object?> get props => [
    name,
    id,
    logoPath,
    originCountry,
  ];
}

class ProductionCountry extends Equatable {
    ProductionCountry({
      required this.iso31661,
      required this.name,
    });

    final String iso31661;
    final String name;

  @override
  List<Object?> get props => [
    iso31661,
    name,
  ];
}


class SpokenLanguage extends Equatable {
    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    final String englishName;
    final String iso6391;
    final String name;

  @override
  List<Object?> get props => [
    englishName,
    iso6391,
    name,
  ];
}
