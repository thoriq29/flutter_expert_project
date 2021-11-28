part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> tv;

  PopularTvLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}
