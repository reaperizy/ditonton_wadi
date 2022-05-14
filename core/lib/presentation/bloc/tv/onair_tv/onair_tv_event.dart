part of 'onair_tv_bloc.dart';

abstract class TvOnAirEvent extends Equatable {
  const TvOnAirEvent();

  @override
  List<Object> get props => [];
}

class TvOnAirGetEvent extends TvOnAirEvent {}
