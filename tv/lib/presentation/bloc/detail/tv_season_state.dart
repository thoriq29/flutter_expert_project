part of 'tv_season_bloc.dart';

abstract class TvSeasonState extends Equatable {
  const TvSeasonState();

  @override
  List<Object> get props => [];
}

class TvSeasonEmpty extends TvSeasonState {}

class TvSeasonLoading extends TvSeasonState {}

class TvSeasonError extends TvSeasonState {
  final String message;

  TvSeasonError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeasonLoaded extends TvSeasonState {
  final int selectedSeasonID;
  final Season result;

  TvSeasonLoaded(this.result, this.selectedSeasonID);

  @override
  List<Object> get props => [result];
}

class TvSelectedSeason extends TvSeasonState {
  final int seasonID;

  TvSelectedSeason(this.seasonID);

  @override
  List<Object> get props => [seasonID];
}
