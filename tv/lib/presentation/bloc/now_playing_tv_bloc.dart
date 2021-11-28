import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  NowPlayingTvBloc(this.getNowPlayingTv) : super(NowPlayingTvEmpty());
  final GetNowPlayingTv getNowPlayingTv;

   @override
  Stream<NowPlayingTvState> mapEventToState(
    NowPlayingTvEvent event,
  ) async* {
    if (event is NowPlayingTvEvent) {
      yield NowPlayingTvLoading();
      final nowPlayingresult = await getNowPlayingTv.execute();

      yield* nowPlayingresult.fold(
        (failure) async* {
        yield NowPlayingTvError(failure.message);
      }, (movie) async* {
        yield NowPlayingTvLoaded(movie);
      });
    }
  }
}
