part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
  
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;
 
  NowPlayingMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<Movie> result;
 
  NowPlayingMoviesLoaded(this.result);
 
  @override
  List<Object> get props => [result];
}