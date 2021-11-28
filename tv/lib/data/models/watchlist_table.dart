
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

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

  factory WatchlistTable.fromTvEntity(TvDetail tv) => WatchlistTable(
    id: tv.id,
    title: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview, 
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


  Tv toTvEntity() => Tv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: title,
  );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
