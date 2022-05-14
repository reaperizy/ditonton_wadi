part of 'onair_tv_bloc.dart';

abstract class TvOnAirState extends Equatable {
  const TvOnAirState();

  @override
  List<Object> get props => [];
}

class TvOnAirEmpty extends TvOnAirState {}

class TvOnAirLoading extends TvOnAirState {}

class TvOnAirError extends TvOnAirState {
  final String message;

  const TvOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class TvOnAirLoaded extends TvOnAirState {
  final List<Tv> result;

  const TvOnAirLoaded(this.result);

  @override
  List<Object> get props => [result];
}
