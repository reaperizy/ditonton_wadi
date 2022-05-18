part of 'detail_movie_bloc.dart';

abstract class DetailsMoviesEvent extends Equatable {
  const DetailsMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsMoviesEvent extends DetailsMoviesEvent {
  final int id;

  const GetDetailsMoviesEvent(this.id);

  @override
  List<Object> get props => [];
}
