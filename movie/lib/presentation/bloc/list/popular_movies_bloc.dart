import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is PopularMoviesEvent) {
      yield PopularMoviesLoading();
      final result = await getPopularMovies.execute();

      yield* result.fold((failure) async* {
        yield PopularMoviesError(failure.message);
      }, (movies) async* {
        yield PopularMoviesLoaded(movies);
      });
    }
  }
}
