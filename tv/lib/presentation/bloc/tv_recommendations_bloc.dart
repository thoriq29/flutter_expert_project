import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';

part 'tv_recommendations_state.dart';
part 'tv_recommendations_event.dart';

class TvRecommendationBloc extends Bloc<TvRecommendationsEvent, TvRecommendationState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationBloc(this._getTvRecommendations) : super(TvRecommendationEmpty());

  @override
  Stream<TvRecommendationState> mapEventToState(
    TvRecommendationsEvent event,
  ) async* {
    if (event is FetchTvRecommendation) {
      yield TvRecommendationLoading();
      final result = await _getTvRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield TvRecommendationError(failure.message);
        },
        (data) async* {
          yield TvRecommendationLoaded(data);
        },
      );
    }
  }
}