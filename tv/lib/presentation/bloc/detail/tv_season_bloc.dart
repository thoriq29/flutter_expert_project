import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/usecases/tv/get_tv_season_episodes.dart';

part 'tv_season_state.dart';
part 'tv_season_event.dart';

class TvSeasonBloc extends Bloc<TvSeasonEvent, TvSeasonState> {
  final GetTvSeasonEpisodes _getTvSeasonEpisodes;

  TvSeasonBloc(this._getTvSeasonEpisodes) : super(TvSeasonEmpty());

  @override
  Stream<TvSeasonState> mapEventToState(
    TvSeasonEvent event,
  ) async* { 
    if(event is SetSelectedSeason) {
      yield TvSelectedSeason(event.selectedSeason);
    } else if(event is GetTvSeasonData) {
      yield TvSeasonLoading();
      final result = await _getTvSeasonEpisodes.execute(event.tvID, event.seasonID);
      yield* result.fold(
        (failure) async* {
          yield TvSeasonError(failure.message);
        },
        (data) async* {
          yield TvSeasonLoaded(data, data.seasonNumber as int);
        },
      );
    }
  }
}