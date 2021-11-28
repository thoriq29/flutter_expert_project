import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(TopRatedMoviesEmpty());

  @override
  Stream<TopRatedMoviesState> mapEventToState(
    TopRatedMoviesEvent event,
  ) async* {
    if (event is TopRatedMoviesEvent) {
      yield TopRatedMoviesLoading();
      final result = await getTopRatedMovies.execute();

      yield* result.fold((failure) async* {
        yield TopRatedMoviesError(failure.message);
      }, (movies) async* {
        yield TopRatedMoviesLoaded(movies);
      });
    }
  }
}
