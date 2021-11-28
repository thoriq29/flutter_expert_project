import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    overview: movie.overview, 
  );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
    id: map['id'],
    title: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'], 
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toMovieEntity() => Movie.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
  );

 
  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
