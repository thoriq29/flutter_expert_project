part of 'tv_season_bloc.dart';

abstract class TvSeasonEvent extends Equatable {
  const TvSeasonEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeasonData extends TvSeasonEvent {
  final int tvID;
  final int seasonID;

  GetTvSeasonData(this.tvID, this.seasonID);

  @override
  List<Object> get props => [tvID, seasonID];

}

class SetSelectedSeason extends TvSeasonEvent {
   final int selectedSeason;

  SetSelectedSeason(this.selectedSeason);

  @override
  List<Object> get props => [selectedSeason];
}
