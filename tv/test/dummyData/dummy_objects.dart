import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_season_model.dart';
import 'package:tv/data/models/watchlist_table.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: "backdropPath", 
  firstAirDate: "firstAirDate", 
  genreIds: [1], 
  id: 1, 
  name: "name", 
  originCountry: ["originCountry"], 
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 99,
  posterPath: "posterPath",
  voteAverage: 69,
  voteCount: 96
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "backdropPath", 
  createdBy: [], 
  episodeRunTime: [1], 
  firstAirDate: "firstAirDate", 
  genres: [Genre(id: 1, name: 'Action')], 
  homepage: "homepage", 
  id: 1, 
  inProduction: false, 
  languages: ["languages"], 
  lastAirDate: "lastAirDate", 
  lastEpisodeToAir: null, 
  name: "name", 
  nextEpisodeToAir: null, 
  networks: [Network(name: "name", id: 1, logoPath: "", originCountry: "originCountry")], 
  numberOfEpisodes: 1,
  numberOfSeasons: 1, 
  originCountry: ["originCountry"], 
  originalLanguage: "originalLanguage", 
  originalName: "originalName", 
  overview: "overview", 
  popularity: 10, 
  posterPath: "posterPath", 
  productionCompanies: [Network(name: "name", id: 1, logoPath: "", originCountry: "originCountry")], 
  productionCountries: [ProductionCountry(iso31661: "iso31661", name: "name")], 
  seasons: [SeasonModel(id: "1", airDate: new DateTime(2021, 10, 16), episodes: [EpisodeModel(airDate: new DateTime(2021, 10, 16), episodeNumber: 1, id: 1, name: "name", overview: "overview", productionCode: "producti1onCode", seasonNumber: 1, stillPath: "stillPath", voteAverage: 1, voteCount: 1)], name: "name", overview: "overview", seasonModelId: 1, posterPath:"1", seasonNumber: 1)], 
  spokenLanguages: [SpokenLanguage(englishName: "englishName", iso6391: "iso6391", name: "name")], 
  status: "status", 
  tagline: "tagline", 
  type: "type", 
  voteAverage: 1, 
  voteCount: 1
);

final testTvSeasonEpisode = Season(
  id: "1", 
  airDate: new DateTime(2021, 10, 16), 
  episodes: [Episode(airDate: new DateTime(2021, 10, 16), episodeNumber: 1, id: 1, name: "name", overview: "overview", productionCode: "producti1onCode", seasonNumber: 1, stillPath: "stillPath", voteAverage: 1, voteCount: 1)],
  name: "name", 
  overview: "overview", 
  seasonModelId: 1,
  posterPath: "posterPath", 
  seasonNumber: 1
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = WatchlistTable(
  id: 1,
  title: 'name',
  posterPath: 'posterPath',
  overview: 'overview', 
);


final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'name',
};