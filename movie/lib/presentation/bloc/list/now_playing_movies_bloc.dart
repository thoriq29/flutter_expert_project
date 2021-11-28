import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({required this.getNowPlayingMovies}) : super(NowPlayingMoviesEmpty());

   @override
  Stream<NowPlayingMoviesState> mapEventToState(
    NowPlayingMoviesEvent event,
  ) async* {
    if (event is NowPlayingMoviesEvent) {
      yield NowPlayingMoviesLoading();
      final nowPlayingresult = await getNowPlayingMovies.execute();

      yield* nowPlayingresult.fold(
        (failure) async* {
        yield NowPlayingMoviesError(failure.message);
      }, (movie) async* {
        yield NowPlayingMoviesLoaded(movie);
      });
    }
  }
}
