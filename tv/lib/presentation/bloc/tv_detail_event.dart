part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailData extends TvDetailEvent {
  final int id;

  GetTvDetailData(this.id);

  @override
  List<Object> get props => [id];
}
