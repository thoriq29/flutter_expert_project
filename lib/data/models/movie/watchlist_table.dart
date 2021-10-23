import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? type;

  WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type
  });

  factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    overview: movie.overview, 
    type: 1,
  );

  factory WatchlistTable.fromTvEntity(TvDetail tv) => WatchlistTable(
    id: tv.id,
    title: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview, 
    type: 2,
  );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
    id: map['id'],
    title: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'], 
    type: map['type'],
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type
      };

  Movie toMovieEntity() => Movie.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
  );

  Tv toTvEntity() => Tv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: title,
  );

  @override
  List<Object?> get props => [id, title, posterPath, overview, type];
}
