import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'search_movie_state.dart';
part 'search_movie_event.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _getSearchMovie;

  SearchMovieBloc(this._getSearchMovie) : super(SearchMovieEmpty());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is FetchSearchMovie) {
      yield SearchMovieLoading();
      final result = await _getSearchMovie.execute(event.query);
      yield* result.fold(
        (failure) async* {
          yield SearchMovieError(failure.message);
        },
        (data) async* {
          if(data.length == 0 ) {
            yield SearchMovieEmpty();
          }
          yield SearchMovieLoaded(data);
        },
      );
    }
  }
}